import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/locator.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  // getter for name of person
  // getter for image of person
  // navigation functions for other options
  void navigateToHome() {
    _navigationService.goBack();
    // _navigationService.navigateTo(HomeRoute);
  }

}