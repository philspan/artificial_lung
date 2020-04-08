import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

class BluetoothModel extends BaseModel {
  final Bluetooth _bluetooth = locator<Bluetooth>();

  BluetoothStatus _bluetoothState = BluetoothStatus.Disconnected;
  BluetoothStatus get bluetoothState => _bluetoothState;
  
  /*
  Future<BluetoothStatus> get bluetoothState async {
    await isConnected();
    return _bluetoothState;
  }*/

  void setState(bluetoothState) {
    _bluetoothState = bluetoothState;
    notifyListeners();
  }

  // might need a rework
  Future initialize() {
    setState(ViewState.Busy);
    _bluetooth.initState();
    return isConnected();
  }

  Future isConnected() async {
    var isConnected = await _bluetooth.isConnected;
    _bluetoothState =
        isConnected ? BluetoothStatus.Connected : BluetoothStatus.Disconnected;
    return _bluetoothState;
  }

  Future<bool> connectToDevice() async {
    await _bluetooth.connectToDevice();
    return isConnected();
  }

  Future<bool> disconnectFromDevice() async {
    await _bluetooth.disconnectFromDevice();
    return isConnected();
  }
}
