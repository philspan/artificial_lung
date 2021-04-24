import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/locator.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _bluetooth = locator<Bluetooth>();
  // getter for name of person
  // getter for image of person
  // navigation functions for other options
  void navigateToHome() {
    _navigationService.goBack();
    // _navigationService.navigateTo(HomeRoute);
  }

  void navigateToConnectToDevice() {
    // TODO create initialization features
    _bluetooth.initialize();

    _navigationService.navigateTo(ConnectDeviceRoute);
    // within settings
    // scans for devices
    // pushes new page with scrollable device list 
    
  }

}