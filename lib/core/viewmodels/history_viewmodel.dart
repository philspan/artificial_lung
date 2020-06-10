import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/locator.dart';
import 'package:stacked/stacked.dart';

class HistoryViewModel extends ReactiveViewModel {
  final _bluetooth = locator<Bluetooth>();
  final _dataService = locator<DataService>();
  final _storage = locator<Storage>();

  List<Datum> get data => _dataService.data;
  List<double> get co2Level => _dataService.co2Level;

  bool get hasData => _dataService.hasData;
  int get dataLength => _dataService.data.length;

  BluetoothStatus get bluetoothState => _bluetooth.bluetoothStatus;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_dataService];

  void addDatumValue(double value) {
    _storage.appendDatumToFile(Datum.value(value));
    _dataService.fetchData().then((value) => null);
    notifyListeners();
  }
}
