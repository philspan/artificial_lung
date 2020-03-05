import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'dart:convert';

class Bluetooth {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamSubscription<ScanResult> scanSubscription;

  BluetoothDevice targetDevice;
  BluetoothCharacteristic targetCharacteristic;

  final String serviceUUID;
  final String characteristicUUID;
  final String deviceName;

  Bluetooth({this.deviceName, this.serviceUUID, this.characteristicUUID});

  void initState() {
    startScan();
  }

  bool get isConnected {
    if (targetDevice != null && targetCharacteristic != null) return true;
    return false;
  }

  startScan() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
    scanSubscription = flutterBlue.scan().listen(
      (scanResult) {
        // search for deviceName
        if (scanResult.device.name == deviceName) {
          flutterBlue.stopScan();
          print('${scanResult.device.name} found! rssi: ${scanResult.rssi}');
          targetDevice = scanResult.device;
          // connectToDevice();
        }
      },
      onDone: () => stopScan(),
    );
  }

  stopScan() {
    scanSubscription?.cancel();
    scanSubscription = null;
  }

  connectToDevice() async {
    if (targetDevice == null) return;

    await targetDevice.connect();
    discoverServices();
  }

  disconnectFromDevice() {
    if (targetDevice == null) return;

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
