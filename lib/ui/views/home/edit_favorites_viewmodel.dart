import 'package:stacked/stacked.dart';
import 'package:artificial_lung/locator.dart';
import 'package:artificial_lung/core/services/navigation.dart';

class EditFavoritesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // getter for current favorited items

  void navigateToHome() {
    _navigationService.goBack();
    // _navigationService.navigateTo(HomeRoute);
  }

  favoriteItem() {}
  // favoriteItem func
  // unfavoriteItem func
}
