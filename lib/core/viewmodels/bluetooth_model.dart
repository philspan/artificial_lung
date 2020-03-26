import 'package:artificial_lung/core/enums/viewstate.dart';
import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

class BluetoothModel extends BaseModel {
  final Bluetooth _bluetooth = locator<Bluetooth>();

  // might need a rework
  Future<bool> initialize() {
    setState(ViewState.Busy);
    _bluetooth.initState();
    return isConnected();
  }

  Future<bool> isConnected() async {
    setState(ViewState.Busy);
    var isConnected = await _bluetooth.isConnected;
    setState(ViewState.Idle);
    return isConnected;
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
