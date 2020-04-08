import 'dart:async';
import 'dart:convert';

import 'package:artificial_lung/core/enums/enums.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  StreamSubscription<ScanResult> scanSubscription;
  // StreamSubscription<BluetoothDeviceState> deviceStateSubscription;
  StreamController<BluetoothStatus> connectionStatusController =
      StreamController<BluetoothStatus>.broadcast();

  BluetoothDevice targetDevice;
  BluetoothCharacteristic targetCharacteristic;

  final String serviceUUID;
  final String characteristicUUID;
  final String deviceName;

  Bluetooth({this.deviceName, this.serviceUUID, this.characteristicUUID});

  void initState() {
    // initState method called automatically when inserted into the tree
    startScan();
  }

  BluetoothStatus _getStateFromEvent(event) {
    switch (event) {
      case BluetoothDeviceState.disconnected:
        return BluetoothStatus.Disconnected;
      case BluetoothDeviceState.connected:
        return BluetoothStatus.Connected;
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
      connectionStatusController.add(BluetoothStatus.Disconnected);
      return;
    }

    await targetDevice.connect();

    targetDevice.state.listen((BluetoothDeviceState event) {
      var connectionStatus = _getStateFromEvent(event);
      connectionStatusController.add(connectionStatus);
    }, onError: () {
      connectionStatusController.add(BluetoothStatus.Disconnected);
    });

    List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
    if (connectedDevices.contains(deviceName)) {
      discoverServices();
      print(targetDevice.name);
    }
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
            writeData("Connected");
            // setstate to device ready
          }
        });
      }
    });
  }

  writeData(String data) async {
    if (targetCharacteristic == null) return;
    List<int> bytes = utf8.encode(data);
    await targetCharacteristic.write(bytes);
  }
}
