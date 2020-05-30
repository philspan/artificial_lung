import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

class ServoRegulationViewModel extends BaseModel {
  final _bluetooth = locator<Bluetooth>();
  final _dataService = locator<DataService>();

  int get systemMode => _dataService.first.sysMode;

  double get co2Level => _dataService.first.co2Level;

  double get pGain => _dataService.first.pGain;
  double get iGain => _dataService.first.iGain;
  double get dGain => _dataService.first.dGain;

  void enableServoregulation() {
    _bluetooth.dataSendController.add("system mode : 1");
  }

  void enableFlowControl() {
    _bluetooth.dataSendController.add("system mode : 0");
  }

  void updateTargetCO2Level(String value) {
    //TODO implement error handling
    if (value != "")
      _bluetooth.dataSendController.add("CO2 level : ${double.parse(value)}");
  }

  void updatePGain(String value) {
    //TODO implement error handling
    if (value != "")
      _bluetooth.dataSendController
          .add("Proportional gain : ${double.parse(value)}");
  }

  void updateIGain(String value) {
    //TODO implement error handling
    if (value != "")
      _bluetooth.dataSendController
          .add("Integral gain : ${double.parse(value)}");
  }

  void updateDGain(String value) {
    //TODO implement error handling
    if (value != "")
      _bluetooth.dataSendController
          .add("Derivative gain : ${double.parse(value)}");
  }
}
