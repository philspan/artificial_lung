import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/locator.dart';
import 'package:stacked/stacked.dart';

class SensorControlViewModel extends ReactiveViewModel {
  final _dataService = locator<DataService>();
  final _bluetooth = locator<Bluetooth>();

  final String _noData = "No Data";
  String get noData => _noData;

  int get currentMode => _dataService.hasData ? _dataService.recent.systemData.systemMode : null;

  bool get hasCO2Data => co2Removal != null;
  double get co2Removal => _dataService.hasData ? _dataService.recent.co2Data.co2Level : null;

  bool get hasFlowData => flowRate != null;
  double get flowRate => _dataService.hasData ? _dataService.recent.flowData.flowLevel : null;
  double get flowSLPM => _dataService.hasData ? _dataService.recent.flowData.targetLevel : null;

  bool get hasBatteryData => batteryLevel != null;
  double get batteryLevel => _dataService.hasData ? _dataService.recent.batteryData.batteryLevel : null;
  double get batteryVoltage => _dataService.hasData ? _dataService.recent.batteryData.batteryVoltage : null;
  double get batteryCurrent => _dataService.hasData ? _dataService.recent.batteryData.batteryCurrent : null;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_dataService];

}
