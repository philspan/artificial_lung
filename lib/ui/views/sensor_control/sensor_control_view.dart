import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:artificial_lung/ui/views/sensor_control/sensor_control_viewmodel.dart';

class SensorControlView extends StatelessWidget {
  const SensorControlView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SensorControlViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(32, 40, 32, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Sensor Control",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
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
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Mode",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CupertinoSlidingSegmentedControl(
                          children: {
                            0: Padding(
                              padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                              child: Text(
                                "Servoregulation",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            1: Text(
                              "Flow",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          },
                          onValueChanged: (value) {
                            model.updateSelectedMode(value);
                          },
                          groupValue:
                              model.currentMode, // model.selectedMode as value
                          thumbColor: Theme.of(context).colorScheme.primary,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          padding: EdgeInsets.all(4),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Data",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
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
                                      "CO\u2082 Sensor",
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "CO\u2082 Removal (%)",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      model.hasCO2Data
                                          ? model.co2Removal
                                                  .toStringAsFixed(2) +
                                              "%"
                                          : model.noData,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
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
                                      "Flow Sensor",
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Voltage (V)",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      model.hasFlowData
                                          ? model.flowVoltage.toStringAsFixed(2) + "V"
                                          : model.noData,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Flow Rate (LPM)",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      model.hasFlowData
                                          ? model.flowRate.toStringAsFixed(2)
                                          : model.noData,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
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
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                  child: Divider(),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Air Blower",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    Container(
                                      width: 32,
                                      height: 19,
                                      decoration: BoxDecoration(
                                        color: model.recentBlowerSensorStatus
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Voltage (V)",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      model.hasBlowerData
                                          ? model.blowerVoltage.toStringAsFixed(2) +
                                              " V"
                                          : model.noData,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Current (A)",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      model.hasBlowerData
                                          ? model.blowerCurrent.toStringAsFixed(2) +
                                              " A"
                                          : model.noData,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Power (W)",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      model.hasBlowerData
                                          ? model.blowerPower.toStringAsFixed(2) + " W"
                                          : model.noData,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Estimated Flow (SLPM)",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      model.hasBlowerData
                                          ? model.blowerSLPM.toStringAsFixed(2)
                                          : model.noData,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      model.hasBlowerData
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
      viewModelBuilder: () => SensorControlViewModel(),
    );
  }
}
