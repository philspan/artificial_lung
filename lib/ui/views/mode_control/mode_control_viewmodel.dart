import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/locator.dart';
import 'package:stacked/stacked.dart';

class ModeControlViewModel extends BaseViewModel {
  final _dataService = locator<DataService>();
  final _bluetooth = locator<Bluetooth>();

  final String _noData = "N/A";
  String get noData => _noData;

  bool _isWaiting = false;
  bool get isWaiting =>
      _isWaiting; // TODO isBusy? separate into multiple variables per field

  int get currentMode => _dataService.currentMode;

  double get targetCo2 => _dataService.targetCo2Level;
  double get errorCo2 => (_dataService.recentCo2Level - targetCo2).abs();

  double get targetFlowRate => 0;
  double get errorFlowRate => 0;

  double get pGainServo => null;
  double get iGainServo => null;
  double get dGainServo => null;

  double get pGainFlow => 0;
  double get iGainFlow => 0;
  double get dGainFlow => 0;

  void updateTargetCo2(double value) {
    _isWaiting = true;
    notifyListeners();
    // TODO REPLACE W/ setBusy(true);
    // should each spinning icon be separated? i think yes, so
    // probably create separate waiting variables per value? talk to jesse
    _dataService.setTargetCo2(value);
    // _bluetooth.dataSendController.add("CO2 level : $value");
    _isWaiting = false;
    notifyListeners();
  }

  // TODO
  void updateGeneric(double value, int term) {
  }

  void updatePGainServo(double value) {
    _bluetooth.addDataToSendController("pgain servo : $value");
    notifyListeners();
  }

  void updateIGainServo(double value) {
    _bluetooth.addDataToSendController("igain servo : $value");
    notifyListeners();
  }

  void updateDGainServo(double value) {
    _bluetooth.addDataToSendController("dgain servo : $value");
    notifyListeners();
  }

  void updateTargetFlow(double value) {
    _bluetooth.addDataToSendController("target flow : $value");
    notifyListeners();
  }

  void updatePGainFlow(double value) {
    _bluetooth.addDataToSendController("pgain flow : $value");
    notifyListeners();
  }

  void updateIGainFlow(double value) {
    _bluetooth.addDataToSendController("igain flow : $value");
    notifyListeners();
  }

  void updateDGainFlow(double value) {
    _bluetooth.addDataToSendController("dgain flow : $value");
    notifyListeners();
  }
}
