import 'package:artificial_lung/ui/views/connect_device/connect_device_view.dart';
import 'package:artificial_lung/ui/views/graphing/graphing_view.dart';
import 'package:artificial_lung/ui/views/home/edit_favorites_view.dart';
import 'package:artificial_lung/ui/views/navigation/navigation_view.dart';
import 'package:artificial_lung/ui/views/notifications/notifications_view.dart';
import 'package:artificial_lung/ui/views/home/home_view.dart';
import 'package:artificial_lung/ui/views/settings/settings_view.dart';
import 'package:flutter/material.dart';

// define routes
const String NavigationRoute = '/nav';
const String HomeRoute = '/home';
const String NotificationsRoute = '/notifications';
const String SettingsRoute = '/settings';
const String EditFavoritesRoute = '/editfavorites';
const String ConnectDeviceRoute = '/connect';
const String GraphingRoute = '/graph';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  goBack() {
    return navigatorKey.currentState.pop();
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case NavigationRoute:
      return MaterialPageRoute(builder: (context) => NavigationView());
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    case NotificationsRoute:
      return MaterialPageRoute(builder: (context) => NotificationsView());
    // return _getPageRoute(HomeView(), settings);
    case SettingsRoute:
      return MaterialPageRoute(builder: (context) => SettingsView());
    // return _getPageRoute(CO2SensorScreen(), settings);
    case EditFavoritesRoute:
      return MaterialPageRoute(builder: (context) => EditFavoritesView());
    // return _getPageRoute(SettingsView(), settings);
    case ConnectDeviceRoute:
      return MaterialPageRoute(builder: (context) => ConnectDeviceView());
    case GraphingRoute:
      return MaterialPageRoute(builder: (context) => GraphingView());
    default:
      return MaterialPageRoute(builder: (context) => HomeView());
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                child,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}
