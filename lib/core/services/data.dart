import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/locator.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

/// Maintains all data throughout the application.
class DataService with ReactiveServiceMixin {
  final _storage = locator<Storage>();

  RxValue<List<Node>> _data = RxValue<List<Node>>();
  List<Node> get data => _data.value;
  bool get hasData => _data.value != null && _data.value.isNotEmpty;

  DataService() {
    listenToReactiveValues([_data]);
  }

  Future<dynamic> initialize() async {
    await fetchData();
  }

  /// Fetches data from local file and updates application's data.
  Future<List<Node>> fetchData() async {
    // _data = RxList.from(await _storage.readDataFromFile());
    _data.value = await _storage.readFileAsList();
    return _data.value;
  }

  /// Gets most recent data stored in the local file. Allows for access to members of most recent data.
  Node get recent {
    return _data.value.first;
  }
}
