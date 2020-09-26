import 'package:artificial_lung/core/services/data.dart';
import 'package:stacked/stacked.dart';
import 'dart:core';
import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/locator.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final _navigationService = locator<NavigationService>();
  final _dataService = locator<DataService>();

  final String _noData = "No Data";
  String get noData => _noData;

  // getters for date
  bool get hasDate => (weekday != null && date != null);

  String get weekday {
    switch (DateTime.now().weekday) {
      case DateTime.sunday:
        return "Sunday";
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      case DateTime.saturday:
        return "Saturday";
      default:
        return null;
    }
  }

  String get date => "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}";

  bool get hasNotifications =>
      (notificationCount != 0 && notificationCount != null);
  int get notificationCount => 0;

  // getter for favorites count
  int get favoritesCount => 0;
  // getter for list of favorites

  bool get hasSystemData => false;
  get recentSystemDataTimestamp => 0;
  bool get recentSystemStatus => false;
  bool get recentSystemBattery => false;

  bool get hasCO2Data => recentCo2Data != null;
  get recentCO2DataTimestamp => 0;
  bool get recentCO2SensorStatus => _dataService.recentCo2State;
  double get recentCo2Data => _dataService.recentCo2Level;

  bool get hasFlowData => recentFlowRate != null;
  get recentFlowDataTimestamp => 0;
  bool get recentFlowSensorStatus => _dataService.recentFlowState;
  double get recentFlowRate => _dataService.recentFlowRate;

  void navigateToNotifications() {
    _navigationService.navigateTo(NotificationsRoute);
  }

  void navigateToSettings() {
    _navigationService.navigateTo(SettingsRoute);
  }

  void navigateToEditFavorites() {
    _navigationService.navigateTo(EditFavoritesRoute);
  }

  void navigateToSystemHistory() {
    _navigationService.navigateTo(null); // TODO add system history page
  }
}
