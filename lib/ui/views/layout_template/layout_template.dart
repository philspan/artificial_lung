import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/locator.dart';
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
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        activeColor: Theme.of(context).bottomAppBarColor,
        inactiveColor: Theme.of(context).backgroundColor,
        currentIndex: _currentIndex,
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
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                Icons.show_chart,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                CupertinoIcons.gear_solid,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(Icons.memory),
            ),
          ),
        ],
      ),
      body: Center(
        child: this.widget.child,
      ),
    );
  }
}
