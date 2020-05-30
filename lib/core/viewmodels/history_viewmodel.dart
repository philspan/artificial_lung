import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

class HistoryViewModel extends BaseModel {
  final _bluetooth = locator<Bluetooth>();
  final _dataService = locator<DataService>();
  final _storage = locator<Storage>();

  List<Datum> get data => _dataService.data;
  bool get hasData => _dataService.hasData;
  int get dataLength => _dataService.data.length;

  BluetoothStatus get bluetoothState => _bluetooth.bluetoothStatus;

  void addDatumValue(double value) {
    _storage.appendDatumToFile(Datum.value(value));
  }
}
