import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/locator.dart';

class DataService {
  final _storage = locator<Storage>();

  // possibly change to a stream of Data
  List<Datum> _data;
  List<Datum> get data => _data;

  bool get hasData => _data != null && _data.isNotEmpty;

  DataService() {
    fetchData();
  }

  // add functions to handle getting data from list indirectly
  // TODO create getters for parts of data, rather than requiring use of dot operator
  Datum get first {
    return _data.first;
  }
  
  Future<List<Datum>> fetchData() async {
    _data = await _storage.readDataFromFile();
    return _data;
  }
}