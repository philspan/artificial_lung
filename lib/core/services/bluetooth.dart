import 'dart:async';
import 'dart:convert';

import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/locator.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:stacked/stacked.dart';

class Bluetooth with ReactiveServiceMixin {
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
  BluetoothCharacteristic targetWriteCharacteristic;
  BluetoothCharacteristic targetReadCharacteristic;

  final String serviceUUID;
  final String characteristicUUID;
  final String deviceName;
  final String deviceNameCharacteristicUUID =
      "00002a00-0000-1000-8000-00805f9b34fb";

  /// Constructs Bluetooth instance and initializes bluetooth streams.
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
  void initialize() {
    // TODO BT check bluetooth isavailable, inform user to turn on bluetooth
    // TODO BT check if system is already connected, not possible right now
    // TODO BT implement connecting to unknown device

    // on startup:
    // check if bluetooth available, prompt to turn on bluetooth
    // check for previous device, if no device, prompt for new device on startup
    // in menu:
    // prompt for new device.

    // check for previous device, if no device, prompt for new device on startup
    // implement prompt for new device
    _startScan();
  }

  /// Adds data to stream to send from application to lung system.
  void pushDataToSystem(String data) {
    _dataSendController.add(data);
  }

  /// Called by dataSendController when application needs to send data to the bluetooth device.
  void _onDataSend(String data) async {
    await _writeStringToDevice(data);
  }

  /// Called by dataReceiveController when bluetooth device sends data to the application.
  void _onDataReceive(String data) async {
    try {
      // parse data received
      List<String> pairs = data.split("\r\n");
      Map<String, dynamic> parsedMap = Map<String, dynamic>();
      parsedMap["${CO2Data.asString}"] = Map<String, dynamic>();
      parsedMap["${FlowData.asString}"] = Map<String, dynamic>();
      parsedMap["${SystemData.asString}"] = Map<String, dynamic>();
      parsedMap["${BatteryData.asString}"] = Map<String, dynamic>();
      pairs.forEach(
        (element) {
          List<String> separated = element.split('=');
          print(separated);
          if (separated.length > 2)
            throw Exception("Invalid String: $separated");
          switch (separated.first) {
            case "${Node.timestampFromJson}":
              parsedMap["${Node.timestampFromJson}"] = separated.last;
              break;
            // System Data
            case "${SystemData.systemModeFromJson}":
              parsedMap["${SystemData.asString}"]
                      ["${SystemData.systemModeFromJson}"] =
                  int.tryParse(separated.last) ?? separated.last;
              break;
            // Battery Data
            case "${BatteryData.batteryLevelFromJson}":
              parsedMap["${BatteryData.asString}"]
                      ["${BatteryData.batteryLevelFromJson}"] =
                  double.tryParse(separated.last) ?? separated.last;
              break;
            case "${BatteryData.batteryVoltageFromJson}":
              parsedMap["${BatteryData.asString}"]
                      ["${BatteryData.batteryVoltageFromJson}"] =
                  double.tryParse(separated.last) ?? separated.last;
              break;
            case "Current":
              parsedMap["${BatteryData.asString}"]
                      ["${BatteryData.batteryCurrentFromJson}"] =
                  double.tryParse(separated.last) ?? separated.last;
              break;
            case "is charging":
              parsedMap["${BatteryData.asString}"]
                      ["${BatteryData.isChargingFromJson}"] =
                  separated.last.toLowerCase();
              break;
            // CO2 Data
            case "CO2 level":
              parsedMap["${CO2Data.asString}"]["${CO2Data.co2LevelFromJson}"] =
                  double.tryParse(separated.last) ?? separated.last;
              break;
            case "Target CO2 level":
              parsedMap["${CO2Data.asString}"]
                      ["${CO2Data.targetCo2LevelFromJson}"] =
                  double.tryParse(separated.last) ?? separated.last;
              break;
            case "Flow level":
              parsedMap["${FlowData.asString}"]
                      ["${FlowData.flowLevelFromJson}"] =
                  double.tryParse(separated.last) ?? separated.last;
              break;
            case "Target Flow level":
              parsedMap["${FlowData.asString}"]
                      ["${FlowData.targetFlowLevelFromJson}"] =
                  double.tryParse(separated.last) ?? separated.last;
              break;
            // Shared Data
            case "Proportional gain":
              switch (parsedMap["${SystemData.asString}"]
                      ["${SystemData.systemModeFromJson}"]
                  .toString()) {
                case "${SystemData.co2Mode}":
                  parsedMap["${CO2Data.asString}"]
                          ["${CO2Data.pValueFromJson}"] =
                      double.tryParse(separated.last) ?? separated.last;
                  break;
                case "${SystemData.flowMode}":
                  parsedMap["${FlowData.asString}"]
                          ["${FlowData.pValueFromJson}"] =
                      double.tryParse(separated.last) ?? separated.last;
                  break;
                default:
                  // hasn't been assigned
                  print(
                      "Not assigned: ${separated.first}, ${separated.first.runtimeType}");
                  break;
              }
              break;
            case "Integral gain":
              switch (parsedMap["${SystemData.asString}"]
                      ["${SystemData.systemModeFromJson}"]
                  .toString()) {
                case "${SystemData.co2Mode}":
                  parsedMap["${CO2Data.asString}"]
                          ["${CO2Data.iValueFromJson}"] =
                      double.tryParse(separated.last) ?? separated.last;
                  break;
                case "${SystemData.flowMode}":
                  parsedMap["${FlowData.asString}"]
                          ["${FlowData.iValueFromJson}"] =
                      double.tryParse(separated.last) ?? separated.last;
                  break;
                default:
                  // hasn't been assigned
                  print(
                      "Not assigned: ${separated.first}, ${separated.first.runtimeType}");
                  break;
              }
              break;

            case "Derivative gain":
              switch (parsedMap["${SystemData.asString}"]
                      ["${SystemData.systemModeFromJson}"]
                  .toString()) {
                case "${SystemData.co2Mode}":
                  parsedMap["${CO2Data.asString}"]
                          ["${CO2Data.dValueFromJson}"] =
                      double.tryParse(separated.last) ?? separated.last;
                  break;
                case "${SystemData.flowMode}":
                  parsedMap["${FlowData.asString}"]
                          ["${FlowData.dValueFromJson}"] =
                      double.tryParse(separated.last) ?? separated.last;
                  break;
                default:
                  // hasn't been assigned
                  print(
                      "Not assigned: ${separated.first}, ${separated.first.runtimeType}");
                  break;
              }
              break;
            default:
              print(
                  "Not assigned: ${separated.first}, ${separated.first.runtimeType}");
              // throw exception?
              break;
          }
        },
      );
      // insert parsed into file
      await _dataService.fetchData();
      await _storage.appendNodeToFile(Node.fromJson(parsedMap));
      await _dataService.fetchData();
    } catch (e) {
      print(e.toString());
      return;
    }
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
  void _startScan() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
    scanSubscription = flutterBlue.scan().listen(
      (scanResult) {
        print('${scanResult.device.name} found! rssi: ${scanResult.rssi}');
      },
      onDone: () {
        if (targetDevice == null) {
          _connectToDevice(); // adds Disconnected status to stream
          print("targetDevice: $targetDevice");
        }
        _stopScan();
      },
    );
  }

  /// Cancels scan for specified bluetooth device.
  _stopScan() {
    flutterBlue.stopScan();
    scanSubscription?.cancel();
    scanSubscription = null;
  }

  /// Connect to desired bluetooth device and update state.
  Future<void> connectToDevice(BluetoothDevice target) async {
    targetDevice = target;
    await _connectToDevice();
  }

  /// Connects to bluetooth device and updates bluetooth state.
  Future<void> _connectToDevice() async {
    if (targetDevice == null) {
      return;
    }

    deviceStateSubscription = targetDevice.state.listen((event) {
      bluetoothStatus = _getStateFromEvent(event);
    });

    await targetDevice.connect();
    await _discoverServices();
    // await targetReadCharacteristic.setNotifyValue(true);
    print(
        "DeviceName: ${_convertBytesToString(await targetReadCharacteristic.read())}");

    targetReadCharacteristic.value.listen((value) {
      // adds converted string value to the receive controller
      _dataReceiveController.add(_convertBytesToString(value));
    });
  }

  /// Disconnects from bluetooth device.
  void disconnectFromDevice() {
    if (targetDevice == null) return;

    // deviceStateSubscription.cancel();
    targetDevice.disconnect();
  }

  /// Discovers bluetooth services available to device
  Future<void> _discoverServices() async {
    if (targetDevice == null) return;

    List<BluetoothService> services = await targetDevice.discoverServices();
    for (BluetoothService service in services) {
      print(service);
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        // print("characteristic: $characteristic");
        if (characteristic.properties.write) {
          targetWriteCharacteristic = characteristic;
        }
        if (characteristic.properties.read &&
            characteristic.uuid.toString() == deviceNameCharacteristicUUID) {
          // device name characteristic
          targetReadCharacteristic = characteristic;
        }
        // send data to device so it knows it is connected
        // _writeStringToDevice("Connected");
        // setstate to device ready
      }
    }
  }

  /// Writes string to current connected bluetooth device
  Future<Null> _writeStringToDevice(String data) async {
    if (targetWriteCharacteristic == null) return;
    List<int> bytes = utf8.encode(data);
    await targetWriteCharacteristic.write(bytes);
  }

  /// Converts bytes and returns string of bytes
  String _convertBytesToString(List<int> bytes) {
    // possibly throw error and wrap reading in try catch
    if (targetReadCharacteristic == null) return "";
    return utf8.decode(bytes);
  }
}
