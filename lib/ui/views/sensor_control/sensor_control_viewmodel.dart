import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/locator.dart';
import 'package:stacked/stacked.dart';

class SensorControlViewModel extends BaseViewModel {
  final _dataService = locator<DataService>();
  final _bluetooth = locator<Bluetooth>();

  final String _noData = "No Data";
  String get noData => _noData;

  int get currentMode => _dataService.currentMode;

  bool get hasCO2Data => co2Removal != null;
  get recentCO2DataTimestamp => null;
  bool get recentCO2SensorStatus => _dataService.recentCo2State;
  double get co2Removal => _dataService.co2Level.first;

  bool get hasFlowData => flowRate != null;
  get recentFlowDataTimestamp => null;
  bool get recentFlowSensorStatus => _dataService.recentFlowState;
  double get flowVoltage => _dataService.recentFlowVoltage;
  double get flowRate => _dataService.recentFlowRate;

  bool get hasBlowerData => recentBlowerDataTimestamp != null;
  get recentBlowerDataTimestamp => 0;
  get recentBlowerSensorStatus => false;
  double get blowerVoltage => _dataService.recentBlowerVoltage;
  double get blowerCurrent => _dataService.recentBlowerCurrent;
  double get blowerPower => (blowerVoltage * blowerCurrent);
  double get blowerSLPM => _dataService.recentBlowerPower;

  void updateSelectedMode(int value) {
    // TODO uncomment bluetooth send remove dataservice line
    _dataService.currentMode = value;
    // _bluetooth.addDataToSendController("selected mode : $value"); 
    notifyListeners();
  }
}
