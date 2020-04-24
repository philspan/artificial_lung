import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/viewmodels/sensor_model.dart';
import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:artificial_lung/locator.dart';
import 'package:artificial_lung/ui/widgets/adaptive_switch_list_tile.dart';
import 'package:artificial_lung/ui/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return BaseWidget<SensorModel>(
      onModelReady: (model) => {},
      builder: (context, model, child) => Card(
        child: Column(
          children: <Widget>[
            AdaptiveSwitchListTile(
              title: Text("Air Pump Control"),
              value: (model.airState == AirStatus.Enabled),
              activeColor: CupertinoColors.activeGreen,
              onChanged: (changed) {
                // for now, keep servoState line in UI. move to view model function later to incorporate bluetooth
                // create a separate method call for adding values to stream
                if (model.servoState != ServoRegulationStatus.Enabled)
                  changed
                      ? model.airStatusController.add(AirStatus.Enabled)
                      : model.airStatusController.add(AirStatus.Disabled);
              },
            ),
            ListTile(
              title: Text("Current (A)"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (model) => {},
                  builder: (context, model, child) => TextField(
                    controller: TextEditingController(
                        text: model.first.voltage.toStringAsPrecision(4)),
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
            ),
            ListTile(
              title: Text("Voltage (V)"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (model) => {},
                  builder: (context, model, child) => TextField(
                    controller: TextEditingController(
                        text: model.first.voltage.toStringAsPrecision(4)),
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
            ),
            ListTile(
              title: Text("Power (W)"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (model) => {},
                  builder: (context, model, child) => TextField(
                    controller: TextEditingController(
                        text: model.first.power.toStringAsPrecision(4)),
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
            ),
            ListTile(
              title: Text("Estimated Flow (SLPM)"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (model) => {},
                  builder: (context, model, child) => TextField(
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
            ),
          ],
        ),
      ),
    );
  }
}

class FlowCard extends StatelessWidget {
  const FlowCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SensorModel>(
      onModelReady: (model) => {},
      builder: (context, model, child) => Card(
        child: Column(
          children: <Widget>[
            AdaptiveSwitchListTile(
              title: Text("Flow Sensor"),
              value: (model.flowState == FlowStatus.Enabled),
              activeColor: CupertinoColors.activeGreen,
              onChanged: (changed) {
                // for now, keep servoState line in UI. move to view model function later to incorporate bluetooth
                if (model.servoState != ServoRegulationStatus.Enabled)
                  changed
                      ? model.flowStatusController.add(FlowStatus.Enabled)
                      : model.flowStatusController.add(FlowStatus.Disabled);
              },
            ),
            ListTile(
              title: Text("Voltage (V)"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (model) => {},
                  builder: (context, model, child) => TextField(
                    controller: TextEditingController(
                        text: model.first.voltage.toStringAsPrecision(4)),
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
            ),
            ListTile(
              title: Text("Flow (LPM)"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (model) => {},
                  builder: (context, model, child) => TextField(
                    controller: TextEditingController(
                        text: model.first.flowLevel.toStringAsPrecision(4)),
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
            ),
          ],
        ),
      ),
    );
  }
}

class CO2Card extends StatelessWidget {
  const CO2Card({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SensorModel>(
      onModelReady: (model) => {},
      builder: (context, model, child) => Card(
        child: Column(
          children: <Widget>[
            AdaptiveSwitchListTile(
              title: Text("CO\u2082 Sensor"),
              value: (model.co2State == CO2Status.Enabled),
              activeColor: CupertinoColors.activeGreen,
              onChanged: (changed) {
                // for now, keep servoState line in UI. move to view model function later to incorporate bluetooth
                if (model.servoState != ServoRegulationStatus.Enabled)
                  changed
                      ? model.add(
                          model.co2StatusController, CO2Status.Enabled) // TODO
                      //model.co2StatusController.add(CO2Status.Enabled)
                      : model.add(
                          model.co2StatusController, CO2Status.Disabled);
                //model.co2StatusController.add(CO2Status.Disabled);
              },
            ),
            ListTile(
              title: Text("CO\u2082 (%)"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (model) => {},
                  builder: (context, model, child) => TextField(
                    controller: TextEditingController(
                        text: model.first.co2Level.toStringAsPrecision(4)),
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
            ),
          ],
        ),
      ),
    );
  }
}
