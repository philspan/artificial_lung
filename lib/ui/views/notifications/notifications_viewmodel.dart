import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/locator.dart';
import 'package:stacked/stacked.dart';

class NotificationsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // getter for current notifications

  void navigateToHome() {
    _navigationService.goBack();
    // _navigationService.navigateTo(HomeRoute);
  }
  // remove notification function
}
