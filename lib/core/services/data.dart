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

  DataService() {
    fetchData();
    listenToReactiveValues([_data]);
  }

  // add functions to handle getting data from list indirectly
  // TODO create getters for parts of data, rather than requiring use of dot operator
  Datum get first {
    return _data.value.first;
  }

  Future<List<Datum>> fetchData() async {
    // _data = RxList.from(await _storage.readDataFromFile());
    _data.value = await _storage.readDataFromFile();
    return _data.value;
  }
}
