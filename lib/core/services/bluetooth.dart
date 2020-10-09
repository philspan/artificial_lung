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

  StreamController<String> _dataSendController =
      StreamController<String>.broadcast();
  StreamController<String> _dataReceiveController =
      StreamController<String>.broadcast();

  BluetoothDevice targetDevice;
  BluetoothCharacteristic targetCharacteristic;

  final String serviceUUID;
  final String characteristicUUID;
  final String deviceName;

  /// Initializes bluetooth streams and creates Bluetooth instance.
  Bluetooth({this.deviceName, this.serviceUUID, this.characteristicUUID}) {
    _dataSendController.stream.listen((event) {
      // from application to device
      _onDataSend(event);
      _dataReceiveController.add(event);
      // TODO REMOVE: if this^ is added, it acts as if data has been sent through bluetooth and was received everytime you send something
    });
    _dataReceiveController.stream.listen((event) {
      // from device to application
      _onDataReceive(event);
    });
  }

  /// Cancels and closes all streams to prevent memory leaks.
  void dispose() {
    deviceStateSubscription.cancel();
    _dataSendController.close();
    _dataReceiveController.close();
  }

  /// Initializes bluetooth communication and connects to specified device.
  Future initialize() async {
    // TODO check bluetooth isavailable
    // TODO check if system is already connected
    // TODO implement connecting to unknown device

    await _startScan();
  }

  /// Called by dataSendController when application needs to send data to the bluetooth device.
  void _onDataSend(String data) async {
    //TODO format data to be sent. Waiting for Navid
    await _writeData(data);
    // depends on if code should reset and rely on the bluetooth values vs what is passed
  }

  /// Called by dataReceiveController when bluetooth device sends data to the application.
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

  /// Adds data to stream to send from application to lung system.
  void addDataToSendController(String data) {
    _dataSendController.add(data);
  }

  /// Converts bluetooth api state to bluetooth status
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

  /// Starts scan for specified bluetooth device and calls [_connectToDevice] if found.
  _startScan() {
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

              _connectToDevice();
            }
          },
          onDone: () {
            if (targetDevice == null) {
              _connectToDevice(); // adds Disconnected status to stream
              print("targetDevice: ${targetDevice}");
            }
            _stopScan();
          },
        );
      } else {
        _connectToDevice(); // add Disconnected status
      }
    });
  }

  /// Cancels scan for specified bluetooth device.
  _stopScan() {
    scanSubscription?.cancel();
    scanSubscription = null;
  }

  /// Connects to bluetooth device and updates bluetooth state.
  _connectToDevice() async {
    if (targetDevice == null) {
      return;
    }

    deviceStateSubscription = targetDevice.state.listen((event) {
      bluetoothStatus = _getStateFromEvent(event);
    });

    await targetDevice.connect();

    List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
    if (connectedDevices.contains(deviceName)) {
      _discoverServices();
      print(targetDevice.name);
    }

    await targetCharacteristic.setNotifyValue(true);
    targetCharacteristic.value.listen((value) {
      // adds converted string value to the receive controller
      _dataReceiveController.add(_convertData(value));
    });
  }

  /// Disconnects from bluetooth device.
  disconnectFromDevice() {
    if (targetDevice == null) return;

    // deviceStateSubscription.cancel();
    targetDevice.disconnect();
  }

  // Discovers bluetooth services available to device
  _discoverServices() async {
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
