import 'package:animations/animations.dart';
import 'package:artificial_lung/ui/views/mode_control/mode_control_view.dart';
import 'package:artificial_lung/ui/views/sensor_control/sensor_control_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:artificial_lung/ui/views/navigation/navigation_viewmodel.dart';
import 'package:artificial_lung/ui/views/home/home_view.dart';

class NavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        extendBody: true,
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 200),
          reverse: model.reverse,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: getViewForIndex(model.currentIndex),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).colorScheme.background,
            unselectedItemColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            items: [
              BottomNavigationBarItem(
                title: Container(),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Container(),
                icon: Icon(Icons.mood),
              ),
              BottomNavigationBarItem(
                title: Container(),
                icon: Icon(Icons.mood_bad),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => NavigationViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return SensorControlView();
      case 2:
        return ModeControlView();
      default:
        return HomeView();
    }
  }
}
