import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/locator.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class DataService with ReactiveServiceMixin {
  final _storage = locator<Storage>();

  // possibly change to a stream of Data
  RxValue<List<Datum>> _data = RxValue<List<Datum>>();
  // RxList<Datum> _data = RxList<Datum>();
  List<Datum> get data => _data.value;
  
  bool get hasData => _data.value != null && _data.value.isNotEmpty;

  // TODO remove this after moving to data structure
  RxValue<int> _currentMode = RxValue<int>(initial: 0);
  int get currentMode => _currentMode.value;
  set currentMode(int value) => _currentMode.value = value;

  DataService() {
    listenToReactiveValues([_data, _currentMode]);
  }

  Future initialize() async {
    await fetchData();
  }

  // add functions to handle getting data from list indirectly
  // TODO create getters for parts of data, rather than requiring use of dot operator
  Datum get first {
    return _data.value.first;
  }

  // TODO remove later, as this may not be necessarily the dataservice's responsibility
  List<double> get co2Level {
    List<double> co2Level = List<double>();
    _data.value.forEach((element) {
      co2Level.add(element.co2Level);
    });
    return co2Level;
  }

  bool get recentCo2State => _data.value.first.co2State;
  double get recentCo2Level => _data.value.first.co2Level;

  bool get recentFlowState => _data.value.first.flowState;
  double get recentFlowRate => _data.value.first.flowLevel;
  double get recentFlowVoltage => _data.value.first.voltage; //TODO fix

  double get recentBlowerVoltage => _data.value.first.voltage;
  double get recentBlowerCurrent => _data.value.first.current;
  double get recentBlowerPower => _data.value.first.power;
  // TODO separate blower current and voltage from flow

  // TODO add targetCO2 to data structure
  RxValue<double> _targetCo2Level = RxValue<double>(initial: 0);
  double get targetCo2Level => _targetCo2Level.value;

  // TODO remove this after adding to data structure, currently stored locally and not written to file
  void setTargetCo2(double value) {
    _targetCo2Level.value = value;
  }

  Future<List<Datum>> fetchData() async {
    // _data = RxList.from(await _storage.readDataFromFile());
    _data.value = await _storage.readDataFromFile();
    return _data.value;
  }
}
