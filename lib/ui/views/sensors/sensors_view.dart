import 'package:artificial_lung/core/viewmodels/sensors_viewmodel.dart';
import 'package:artificial_lung/ui/widgets/adaptive_switch_list_tile.dart';
import 'package:artificial_lung/ui/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SensorsView extends StatelessWidget {
  const SensorsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          CO2Card(),
          Divider(),
          FlowCard(),
          Divider(),
          AirCard(),
        ],
      ),
    );
  }
}

class AirCard extends StatelessWidget {
  const AirCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SensorsViewModel>.reactive(
        builder: (context, model, child) => Card(
              child: Column(
                children: <Widget>[
                  AdaptiveSwitchListTile(
                    title: Text("Air Pump Control"),
                    value: model.hasData ? model.airState : false,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (changed) {
                      // for now, keep servoState line in UI. move to view model function later to incorporate bluetooth
                      // create a separate method call for adding values to stream
                      // if (model.first.servoState != ServoRegulationStatus.Enabled)
                      changed
                          ? model.enableAirState()
                          : model.disableAirState();
                    },
                  ),
                  ListTile(
                    title: Text("Current (A)"),
                    trailing: FractionallySizedBox(
                      widthFactor: .225,
                      heightFactor: .6,
                      child: TextField(
                        controller: TextEditingController(
                            text: model.hasData ? model.airCurrent.toStringAsPrecision(4) : "No Data"),
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "A",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Voltage (V)"),
                    trailing: FractionallySizedBox(
                      widthFactor: .225,
                      heightFactor: .6,
                      child: TextField(
                        controller: TextEditingController(
                            text: model.hasData ? model.airVoltage.toStringAsPrecision(4) : "No Data"),
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "V",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Power (W)"),
                    trailing: FractionallySizedBox(
                      widthFactor: .225,
                      heightFactor: .6,
                      child: TextField(
                        controller: TextEditingController(
                            text: model.hasData ? model.airPower.toStringAsPrecision(4) : "No Data"),
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "W",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Estimated Flow (SLPM)"),
                    trailing: FractionallySizedBox(
                      widthFactor: .225,
                      heightFactor: .6,
                      child: TextField(
                        controller: TextEditingController(
                            text: "TODO"), // model.first.flowLevel
                        // .toStringAsPrecision(4)),
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => SensorsViewModel());
  }
}

class FlowCard extends StatelessWidget {
  const FlowCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SensorsViewModel>.reactive(
        builder: (context, model, child) => Card(
              child: Column(
                children: <Widget>[
                  AdaptiveSwitchListTile(
                    title: Text("Flow Sensor"),
                    value: model.hasData ? model.flowState : false,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (changed) {
                      // for now, keep servoState line in UI. move to view model function later to incorporate bluetooth
                      if (model.systemMode != 1)
                        changed
                            ? model.enableFlowState()
                            : model.disableFlowState();
                    },
                  ),
                  ListTile(
                    title: Text("Voltage (V)"),
                    trailing: FractionallySizedBox(
                      widthFactor: .225,
                      heightFactor: .6,
                      child: TextField(
                        controller: TextEditingController(
                            text: model.hasData ? model.airVoltage.toStringAsPrecision(4) : "No Data"),
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "V",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Flow (LPM)"),
                    trailing: FractionallySizedBox(
                      widthFactor: .225,
                      heightFactor: .6,
                      child: TextField(
                        controller: TextEditingController(
                            text: model.hasData ? model.flowLevel.toStringAsPrecision(4) : "No Data"),
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => SensorsViewModel());
  }
}

class CO2Card extends StatelessWidget {
  const CO2Card({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SensorsViewModel>.reactive(
        builder: (context, model, child) => Card(
              child: Column(
                children: <Widget>[
                  AdaptiveSwitchListTile(
                    title: Text("CO\u2082 Sensor"),
                    value: model.hasData ? model.co2State : false,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (changed) {
                      if (model.systemMode != 1)
                        changed
                            ? model.enableCO2State()
                            : model.disableCO2State();
                    },
                  ),
                  ListTile(
                    title: Text("CO\u2082 (%)"),
                    trailing: FractionallySizedBox(
                      widthFactor: .225,
                      heightFactor: .6,
                      child: TextField(
                        controller: TextEditingController(
                            text: model.hasData ? model.co2Level.toStringAsPrecision(4) : "No Data"),
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "%",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => SensorsViewModel());
  }
}
