import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

class BluetoothModel extends BaseModel {
  final Bluetooth _bluetooth = locator<Bluetooth>();

  bool connection = false;

  // might need a rework
  Future initialize() {
    setState(ViewState.Busy);
    _bluetooth.initState();
    return isConnected();
  }

  Future isConnected() async {
    setState(ViewState.Busy);
    var isConnected = await _bluetooth.isConnected;
    Future.delayed(Duration(seconds: 2));
    setState(ViewState.Idle);
    connection = isConnected;
    return connection;
  }

  Future<bool> connectToDevice() async {
    setState(ViewState.Busy);
    await _bluetooth.connectToDevice();
    return isConnected();
  }

  Future<bool> disconnectFromDevice() async {
    setState(ViewState.Busy);
    await _bluetooth.disconnectFromDevice();
    return isConnected();
  }
}
