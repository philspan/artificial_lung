import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

class BluetoothModel extends BaseModel {
  final Bluetooth _bluetooth = locator<Bluetooth>();

  BluetoothStatus _bluetoothState = BluetoothStatus.Disconnected;
  BluetoothStatus get bluetoothState => _bluetoothState;

  BluetoothModel() {
    initState();
  }

  @override
  void dispose() {
    _bluetooth.connectionStatusController.close();
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
    return bluetoothState;
  }

  Future disconnectFromDevice() async {
    await _bluetooth.disconnectFromDevice();
    return bluetoothState;
  }
}
