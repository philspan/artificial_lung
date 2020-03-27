import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:artificial_lung/locator.dart';
import 'package:artificial_lung/ui/views/baseview/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutTemplate extends StatefulWidget {
  final Widget child;
  const LayoutTemplate({Key key, @required this.child}) : super(key: key);

  @override
  _LayoutTemplateState createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return BaseView<StorageModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: _currentIndex,
          activeColor: CupertinoColors.activeBlue,
          onTap: (int value) {
            if (_currentIndex != value) {
              setState(() {
                _currentIndex = value;
              });
              switch (value) {
                case 0:
                  locator<NavigationService>().navigateTo(HistoryRoute);
                  break;
                case 1:
                  locator<NavigationService>().navigateTo(SensorsRoute);
                  break;
                case 2:
                  locator<NavigationService>().navigateTo(ServoRegulationRoute);
                  break;
              }
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.gear_solid),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.memory),
            ),
          ],
        ),
        backgroundColor: CupertinoColors.lightBackgroundGray,
        body: Center(
          child: this.widget.child,
        ),
      ),
    );
  }
}
