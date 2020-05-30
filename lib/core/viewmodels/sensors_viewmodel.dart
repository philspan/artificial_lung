import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

class SensorsViewModel extends BaseModel {
  final _bluetooth = locator<Bluetooth>();
  final _dataService = locator<DataService>();

  int get systemMode => _dataService.first.sysMode;

  bool get airState => _dataService.first.airState;
  double get airVoltage => _dataService.first.voltage;
  double get airCurrent => _dataService.first.current;
  double get airPower => _dataService.first.power;

  bool get flowState => _dataService.first.flowState;
  double get flowLevel => _dataService.first.flowLevel;

  bool get co2State => _dataService.first.co2State;
  double get co2Level => _dataService.first.co2Level;

  void enableAirState() {
    _bluetooth.dataSendController.add("air state : true");
    notifyListeners();
  }

  void disableAirState() {
    _bluetooth.dataSendController.add("air state : false");
    notifyListeners();
  }

  void enableFlowState() {
    _bluetooth.dataSendController.add("flow state : true");
    notifyListeners();
  }

  void disableFlowState() {
    _bluetooth.dataSendController.add("flow state : false");
    notifyListeners();
  }

  void enableCO2State() {
    _bluetooth.dataSendController.add("co2 state : true");
    notifyListeners();
  }

  void disableCO2State() {
    _bluetooth.dataSendController.add("co2 state : false");
    notifyListeners();
  }
}
