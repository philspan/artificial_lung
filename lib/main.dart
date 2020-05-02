import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/ui/views/layout_template/layout_template.dart';
import 'package:flutter/material.dart';
import 'package:artificial_lung/locator.dart';

void main() {
  setupLocator();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepPurpleAccent,
        brightness: Brightness.dark,
      ),
      builder: (context, child) => LayoutTemplate(child: child),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: StartupRoute,
    );
  }
}
