import 'dart:async';
import 'dart:core';

import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:artificial_lung/locator.dart';

class BluetoothModel extends BaseModel {
  final Bluetooth _bluetooth = locator<Bluetooth>();

  BluetoothStatus _bluetoothState = BluetoothStatus.Disconnected;
  BluetoothStatus get bluetoothState => _bluetoothState;

  //TODO make streams private _, create functions to add to streams
  StreamController<String> dataSendController =
      StreamController<String>.broadcast();
  StreamController<String> dataReceiveController =
      StreamController<String>.broadcast();

  BluetoothModel() {
    initState();
    dataSendController.stream.listen((event) {
      // from application to device
      _onDataSend(event);
      dataReceiveController.add(event);
      //TODO if this^ is added, it acts as if data has been sent through bluetooth and was received everytime u send something
    });
    dataReceiveController.stream.listen((event) {
      // from device to application
      _onDataReceive(event);
    });
  }

  // Private function called by dataSendController when application needs to send data to the bluetooth device.
  // dataSendController listens to data sent from UI text fields and switches. When sending, it calls this function.
  void _onDataSend(String data) async {
    //TODO format data to be sent. Waiting for Navid
    await _bluetooth.writeData(data);
    await locator<StorageModel>().readJSON(); // TODO should this be here?
    // depends on if we want the code to reset and rely on the bluetooth values vs what we pass
  }

  // Private function called by dataReceiveController when bluetooth device sends data to the application.
  // dataReceiveController listens to data sent by the bluetooth device. When received, it calls this function.
  void _onDataReceive(String data) async {
    //TODO is currently under the assumption that each send is one string of key, value pair, waiting for Navid. CHANGE soon

    //TODO check for null data string first
    List<String> pair = data.split(" : "); // key,value
    String key = pair.first;
    dynamic value = (key.contains("state") ? (pair.last == "true") : double.parse(pair.last)); 
    if (key.contains("system mode")) value = int.parse(pair.last);
      
    if (pair.length > 2) {
      print("error: onDataReceive passed incorrectly formatted string");
      return;
    }

    //TODO move this to StorageModel
    await locator<StorageModel>().readJSON();
    Map newData = locator<StorageModel>().first.toJson();
    newData[key] = value;
    locator<StorageModel>().writeJSON(Datum.fromJson(newData));
    await locator<StorageModel>().readJSON(); // refresh file, TODO not needed?
  }

  @override
  void dispose() {
    _bluetooth.connectionStatusController.close();
    dataSendController.close();
    dataReceiveController.close();
    super.dispose();
  }

  void initState() {
    _bluetooth.initState();
    _bluetooth.connectionStatusController.stream.listen((event) {
      setState(event);
      print(event); // prints in console at every change
    });
  }

  void setState(bluetoothState) {
    _bluetoothState = bluetoothState;
    notifyListeners();
  }

  Future connectToDevice() async {
    await _bluetooth.connectToDevice();
    _bluetooth.targetCharacteristic.setNotifyValue(true); // await ?
    _bluetooth.targetCharacteristic.value.listen((value) {
      // adds converted string value to the receive controller
      dataReceiveController.add(_bluetooth.readData(value));
    });
    return bluetoothState;
  }

  Future disconnectFromDevice() async {
    await _bluetooth.disconnectFromDevice();
    return bluetoothState;
  }
}
