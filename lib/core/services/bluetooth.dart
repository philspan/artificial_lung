import 'dart:async';
import 'dart:convert';

import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/locator.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final _dataService = locator<DataService>();
  final _storage = locator<Storage>();

  StreamSubscription<ScanResult> scanSubscription;
  StreamSubscription<BluetoothDeviceState> deviceStateSubscription;
  BluetoothStatus bluetoothStatus = BluetoothStatus.Disconnected;

  //TODO make streams private _, create functions to add to streams
  StreamController<String> dataSendController =
      StreamController<String>.broadcast();
  StreamController<String> dataReceiveController =
      StreamController<String>.broadcast();

  BluetoothDevice targetDevice;
  BluetoothCharacteristic targetCharacteristic;

  final String serviceUUID;
  final String characteristicUUID;
  final String deviceName;

  Bluetooth({this.deviceName, this.serviceUUID, this.characteristicUUID}) {
    dataSendController.stream.listen((event) {
      // from application to device
      _onDataSend(event);
      dataReceiveController.add(event);
      // TODO REMOVE: if this^ is added, it acts as if data has been sent through bluetooth and was received everytime you send something
    });
    dataReceiveController.stream.listen((event) {
      // from device to application
      _onDataReceive(event);
    });
  }

  void dispose() {
    deviceStateSubscription.cancel();
    dataSendController.close();
    dataReceiveController.close();
  }

  Future initialize() async {
    // TODO check bluetooth isavailable
    // TODO check if system is already connected
    // TODO implement connecting to unknown device

    await startScan();
  }

  // Private function called by dataSendController when application needs to send data to the bluetooth device.
  // dataSendController listens to data sent from UI text fields and switches. When sending, it calls this function.
  void _onDataSend(String data) async {
    //TODO format data to be sent. Waiting for Navid
    await _writeData(data);
    // depends on if code should reset and rely on the bluetooth values vs what is passed
  }

  // Private function called by dataReceiveController when bluetooth device sends data to the application.
  // dataReceiveController listens to data sent by the bluetooth device. When received, it calls this function.
  void _onDataReceive(String data) async {
    //TODO is currently under the assumption that each send is one string of key, value pair, waiting for Navid. CHANGE soon

    //TODO check for null data string first
    List<String> pair = data.split(" : "); // key,value
    String key = pair.first;
    dynamic value = (key.contains("state")
        ? (pair.last == "true")
        : double.parse(pair.last));
    if (key.contains("system mode")) value = int.parse(pair.last);

    if (pair.length > 2) {
      print("error: onDataReceive passed incorrectly formatted string");
      return;
    }

    await _dataService.fetchData();
    Map<String, dynamic> newData = _dataService.first.toJson();
    newData[key] = value;
    await _storage.appendDatumToFile(Datum.fromJson(newData));
    await _dataService.fetchData(); // refresh app data, TODO not needed?
  }

  void addDataToSendController(String data) {
    dataSendController.add(data);
  }

  BluetoothStatus _getStateFromEvent(event) {
    switch (event) {
      case BluetoothDeviceState.disconnected:
        return BluetoothStatus.Disconnected;
      case BluetoothDeviceState.connected:
        return BluetoothStatus.Connected;
      case BluetoothDeviceState.connecting:
        return BluetoothStatus.Connecting;
      case BluetoothDeviceState.disconnecting:
        return BluetoothStatus.Disconnecting;
      default:
        return BluetoothStatus.Disconnected;
    }
  }

  startScan() {
    flutterBlue.isAvailable.then((value) {
      if (value) {
        flutterBlue.startScan(timeout: Duration(seconds: 4));

        // Listen to scan results
        scanSubscription = flutterBlue.scan().listen(
          (scanResult) {
            // search for deviceName
            if (scanResult.device.name == deviceName) {
              flutterBlue.stopScan();
              print(
                  '${scanResult.device.name} found! rssi: ${scanResult.rssi}');
              targetDevice = scanResult.device;

              connectToDevice();
            }
          },
          onDone: () {
            if (targetDevice == null) {
              connectToDevice(); // adds Disconnected status to stream
              print("targetDevice: ${targetDevice}");
            }
            stopScan();
          },
        );
      } else {
        connectToDevice(); // add Disconnected status
      }
    });
  }

  stopScan() {
    scanSubscription?.cancel();
    scanSubscription = null;
  }

  connectToDevice() async {
    if (targetDevice == null) {
      return;
    }

    deviceStateSubscription = targetDevice.state.listen((event) {
      bluetoothStatus = _getStateFromEvent(event);
    });

    await targetDevice.connect();

    List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
    if (connectedDevices.contains(deviceName)) {
      discoverServices();
      print(targetDevice.name);
    }

    await targetCharacteristic.setNotifyValue(true);
    targetCharacteristic.value.listen((value) {
      // adds converted string value to the receive controller
      dataReceiveController.add(_convertData(value));
    });
  }

  disconnectFromDevice() {
    if (targetDevice == null) return;

    // deviceStateSubscription.cancel();
    targetDevice.disconnect();
  }

  // discover services available to device
  discoverServices() async {
    if (targetDevice == null) return;

    List<BluetoothService> services = await targetDevice.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == serviceUUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == characteristicUUID) {
            targetCharacteristic = characteristic;
            // send data to device so it knows it is connected
            _writeData("Connected");
            // setstate to device ready
          }
        });
      }
    });
  }

  Future<Null> _writeData(String data) async {
    if (targetCharacteristic == null) return;
    List<int> bytes = utf8.encode(data);
    await targetCharacteristic.write(bytes);
  }

  String _convertData(List<int> bytes) {
    // possibly throw error and wrap reading in try catch
    if (targetCharacteristic == null) return "";
    return utf8.decode(bytes);
  }
}
