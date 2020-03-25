import 'package:artificial_lung/ui/views/history/history_view.dart';
import 'package:artificial_lung/ui/views/sensors/sensors_view.dart';
import 'package:artificial_lung/ui/views/servoregulation/servoregulation_view.dart';
import 'package:flutter/material.dart';

// define routes
const String HistoryRoute = '/history';
const String SensorsRoute = '/sensors';
const String ServoRegulationRoute = '/servoregulation';

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
      return MaterialPageRoute(builder: (context) => HistoryView());
    // return _getPageRoute(HomeView(), settings);
    case SensorsRoute:
      return MaterialPageRoute(builder: (context) => SensorsView());
    // return _getPageRoute(CO2SensorScreen(), settings);
    case ServoRegulationRoute:
      return MaterialPageRoute(builder: (context) => ServoRegulationView());
    // return _getPageRoute(SettingsView(), settings);
    default:
      return MaterialPageRoute(builder: (context) => SensorsView());
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
