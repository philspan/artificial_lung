import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/locator.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _bluetooth = locator<Bluetooth>();
  final _storage = locator<Storage>();
  final _dataService = locator<DataService>();

  Future<void> initialize() async {
    // initialize Bluetooth
    await _bluetooth.initialize();

    // initialize Storage
    await _storage.initialize();

    // initialize Data
    await _dataService.initialize();

    indicateComplete();
  }

  void indicateComplete() {
    _navigationService.navigateTo(NavigationRoute);
  }
}
