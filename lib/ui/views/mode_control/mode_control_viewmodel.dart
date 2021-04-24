import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/locator.dart';
import 'package:stacked/stacked.dart';

class ModeControlViewModel extends ReactiveViewModel {
  final _dataService = locator<DataService>();
  final _bluetooth = locator<Bluetooth>();

  final String _noData = "N/A";
  String get noData => _noData;

  bool _isModifiedMode = false;
  bool _isModifiedPGain = false;
  bool _isModifiedIGain = false;
  bool _isModifiedDGain = false;

  List<bool> get isModified => [_isModifiedMode, _isModifiedPGain, _isModifiedIGain, _isModifiedDGain];
  List<dynamic> modifiedValues = [0,0,0,0];

  int get currentMode =>
      _dataService.hasData ? _dataService.recent.systemData.systemMode : 0;

  double get targetCo2 =>
      _dataService.hasData ? _dataService.recent.co2Data.targetLevel ?? 0 : 0;
  double get errorCo2 => _dataService.hasData
      ? (_dataService.recent.co2Data.co2Level ?? 0 - targetCo2).abs()
      : 0;

  double get targetFlowRate => _dataService.recent.flowData.targetLevel ?? 0;
  double get errorFlowRate =>
      ((_dataService.recent.flowData.flowLevel ?? 0) - (targetFlowRate ?? 0))
          .abs();

  double get pGainServo => _dataService.recent.co2Data.pValue;
  double get iGainServo => _dataService.recent.co2Data.iValue;
  double get dGainServo => _dataService.recent.co2Data.dValue;

  double get pGainFlow => _dataService.recent.flowData.pValue;
  double get iGainFlow => _dataService.recent.flowData.iValue;
  double get dGainFlow => _dataService.recent.flowData.dValue;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_dataService,];

  void updateSelectedMode(int value) {
    modifiedValues[0] = value;
    _isModifiedMode = true;
    // _bluetooth.pushDataToSystem("${SystemData.systemModeFromJson}=$value\r\n");
    notifyListeners();
  }

  // TODO create generic bluetooth send function to reduce code duplication
  // void updateGeneric(double value, int term);
  void updateGeneric() {
    _isModifiedMode = false;
    _isModifiedPGain = false;
    _isModifiedIGain = false;
    _isModifiedDGain = false;
    _bluetooth.pushDataToSystem("${SystemData.systemModeFromJson}=${modifiedValues[0]}\r\n${CO2Data.pValueFromJson}=${modifiedValues[1]}\r\n${CO2Data.iValueFromJson}=${modifiedValues[2]}\r\n${CO2Data.dValueFromJson}=${modifiedValues[3]}\r\n");
    // _bluetooth.pushDataToSystem("$term=$value\r\n");
    notifyListeners();
  }

  void updateTargetCo2(double value) {
    _bluetooth.pushDataToSystem("${CO2Data.targetCo2LevelFromJson}=$value\r\n");
    notifyListeners();
  }

  void updatePGainServo(double value) {
    modifiedValues[1] = value;
    _isModifiedPGain = true;
    // _bluetooth.pushDataToSystem("${CO2Data.pValueFromJson}=$value\r\n");
    notifyListeners();
  }

  void updateIGainServo(double value) {
    modifiedValues[2] = value;
    _isModifiedIGain = true;
    // _bluetooth.pushDataToSystem("${CO2Data.iValueFromJson}=$value\r\n");
    notifyListeners();
  }

  void updateDGainServo(double value) {
    modifiedValues[3] = value;
    _isModifiedDGain = true;
    // _bluetooth.pushDataToSystem("${CO2Data.dValueFromJson}=$value\r\n");
    notifyListeners();
  }

  void updateTargetFlow(double value) {
    _bluetooth
        .pushDataToSystem("${FlowData.targetFlowLevelFromJson}=$value\r\n");
    notifyListeners();
  }

  void updatePGainFlow(double value) {
    modifiedValues[1] = value;
    _isModifiedPGain = true;
    // _bluetooth.pushDataToSystem("${FlowData.pValueFromJson}=$value\r\n");
    notifyListeners();
  }

  void updateIGainFlow(double value) {
    modifiedValues[2] = value;
    _isModifiedIGain = true;
    // _bluetooth.pushDataToSystem("${FlowData.iValueFromJson}=$value\r\n");
    notifyListeners();
  }

  void updateDGainFlow(double value) {
    modifiedValues[3] = value;
    _isModifiedDGain = true;
    // _bluetooth.pushDataToSystem(
    //     "${SystemData.systemModeFromJson}=${SystemData.flowMode}\r\n${BatteryData.batteryVoltageFromJson}=67\r\n${CO2Data.co2LevelFromJson}=33\r\n${FlowData.iValueFromJson}=$value\r\n${FlowData.flowLevelFromJson}=24\r\n");
    // _bluetooth.pushDataToSystem("${FlowData.dValueFromJson}=$value\r\n");
    notifyListeners();
  }
}
