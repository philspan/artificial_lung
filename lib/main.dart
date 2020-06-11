import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/ui/themes/theme_data.dart';
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
      title: 'Artificial Lung Servoregulator',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      builder: (context, child) => LayoutTemplate(child: child),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: StartupRoute,
    );
  }
}
