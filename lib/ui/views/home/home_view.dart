import 'package:artificial_lung/ui/views/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(32, 20, 32, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: model.hasDate
                        ? <Widget>[
                            Text(
                              model.weekday + ",",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text(
                              model.date,//"April 29th, 2020",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ]
                        : <Widget>[],
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          //TODO implement routing to notifications view
                          model.navigateToNotifications();
                          print("notifications tapped");
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            Icon(
                              model.hasNotifications
                                  ? Icons.notifications
                                  : Icons.notifications_none,
                              size: 50,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            model.hasNotifications
                                ? Container(
                                    width: 26,
                                    height: 26,
                                    child: Center(
                                      child: Text(
                                        model.notificationCount?.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .apply(
                                                color: Theme.of(context)
                                                    .backgroundColor),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).disabledColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.0,
                                          color: Theme.of(context)
                                              .backgroundColor),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                        height: 0,
                      ),
                      GestureDetector(
                        onTap: () {
                          //TODO implement routing to settings view
                          model.navigateToSettings();
                          print("settings tapped");
                        },
                        child: Icon(
                          Icons.settings,
                          size: 50,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                //TODO implement routing to System History view
                model.navigateToSystemHistory();
                print("System tapped");
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(32, 0, 32, 16),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "System",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Status",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Container(
                          width: 32,
                          height: 19,
                          decoration: BoxDecoration(
                            color: model.recentSystemStatus
                                ? Theme.of(context).indicatorColor
                                : Theme.of(context).disabledColor,
                            border: Border.all(
                                width: 1.0,
                                color: Theme.of(context).backgroundColor),
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Battery",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Container(
                          width: 32,
                          height: 19,
                          decoration: BoxDecoration(
                            color: model.recentSystemBattery
                                ? Theme.of(context).indicatorColor
                                : Theme.of(context).disabledColor,
                            border: Border.all(
                                width: 1.0,
                                color: Theme.of(context).backgroundColor),
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          model.hasSystemData
                              ? "April 29, 10:07 AM"
                              : model.noData,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          "Tap to see more",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(41)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(32, 28, 32, 0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Overview",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            GestureDetector(
                              onTap: () {
                                //TODO implement routing to edit view
                                model.navigateToEditFavorites();
                                print("Edit tapped");
                              },
                              child: Text(
                                "Edit",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 13.5, 16, 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "CO\u2082 Removal",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    Container(
                                      width: 32,
                                      height: 19,
                                      decoration: BoxDecoration(
                                        color: model.recentCO2SensorStatus
                                            ? Theme.of(context).indicatorColor
                                            : Theme.of(context).disabledColor,
                                        border: Border.all(
                                            width: 1.0,
                                            color: Theme.of(context)
                                                .backgroundColor),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  model.hasCO2Data
                                      ? model.recentCo2Data.toStringAsFixed(2) + "%"
                                      : model.noData,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(model.hasCO2Data
                                        ? "April 29, 10:07 AM"
                                        : model.noData),
                                    Text("Tap to see more"),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                  child: Divider(),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Flow Rate",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    Container(
                                      width: 32,
                                      height: 19,
                                      decoration: BoxDecoration(
                                        color: model.recentFlowSensorStatus
                                            ? Theme.of(context).indicatorColor
                                            : Theme.of(context).disabledColor,
                                        border: Border.all(
                                            width: 1.0,
                                            color: Theme.of(context)
                                                .backgroundColor),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  model.hasFlowData
                                      ? model.recentFlowRate.toStringAsFixed(2) + " L/min"
                                      : model.noData,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      model.hasFlowData
                                          ? "April 29, 10:07 AM"
                                          : model.noData,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      "Tap to see more",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
