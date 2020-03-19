import 'package:artificial_lung/co2.dart';
import 'package:artificial_lung/views/home/home_view.dart';
import 'package:artificial_lung/views/settings/settings_view.dart';
import 'package:flutter/material.dart';

// define routes
const String HistoryRoute = '/history';
const String SettingsRoute = '/settings';
const String BluetoothRoute = '/bluetooth';
// const String AnotherRoute = '/routename';

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
    case HistoryRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    // return _getPageRoute(HomeView(), settings);
    case SettingsRoute:
      return MaterialPageRoute(builder: (context) => CO2SensorScreen());
    // return _getPageRoute(CO2SensorScreen(), settings);
    case BluetoothRoute:
      return MaterialPageRoute(builder: (context) => SettingsView());
    // return _getPageRoute(SettingsView(), settings);
    default:
      return MaterialPageRoute(builder: (context) => CO2SensorScreen());
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
