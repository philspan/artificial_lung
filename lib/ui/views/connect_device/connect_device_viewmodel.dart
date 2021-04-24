import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:stacked/stacked.dart';
import 'package:artificial_lung/locator.dart';
import 'package:artificial_lung/core/services/navigation.dart';

class ConnectDeviceViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _bluetooth = locator<Bluetooth>();
      
  Stream<List<ScanResult>> get scanResults =>
      _bluetooth.flutterBlue.scanResults;
  Future<List<BluetoothDevice>> get connectedDevices => _bluetooth.flutterBlue.connectedDevices;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_bluetooth];

  void navigateToHome() {
    _navigationService.goBack();
    // _navigationService.navigateTo(HomeRoute);
  }

  void initialize() {
    _bluetooth.initialize();
  }

  /// Connects to specified device given a target BluetoothDevice
  void connectToDevice(BluetoothDevice target) {
    notifyListeners();
    _bluetooth
        .connectToDevice(target)
        .then((value) => print(
            _bluetooth.bluetoothStatus == BluetoothStatus.Connected
                ? 'Connected to ${_bluetooth.targetDevice.toString()}'
                : 'Failed'))
        .catchError((e) => print(e))
        .whenComplete(() {});
    notifyListeners();
  }

  void disconnectFromDevice(BluetoothDevice target) {
    notifyListeners();
    BluetoothDevice old = _bluetooth.targetDevice;
    _bluetooth.targetDevice = target;
    _bluetooth.disconnectFromDevice();
    _bluetooth.targetDevice = old;
    notifyListeners();
  }
}
