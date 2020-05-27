import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:artificial_lung/core/viewmodels/bluetooth_model.dart';
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
    return BaseWidget<BluetoothModel>(
      onModelReady: (bluetooth) => {},
      builder: (context, bluetooth, child) => BaseWidget<StorageModel>(
        onModelReady: (storage) => {},
        builder: (context, storage, child) => Card(
          child: Column(
            children: <Widget>[
              AdaptiveSwitchListTile(
                title: Text("Air Pump Control"),
                value: storage.first.airState,
                activeColor: CupertinoColors.activeGreen,
                onChanged: (changed) {
                  // for now, keep servoState line in UI. move to view model function later to incorporate bluetooth
                  // create a separate method call for adding values to stream
                  // if (model.first.servoState != ServoRegulationStatus.Enabled)
                  changed
                      ? bluetooth.dataSendController.add("air state : true")
                      : bluetooth.dataSendController.add("air state : false");
                },
              ),
              ListTile(
                title: Text("Current (A)"),
                trailing: FractionallySizedBox(
                  widthFactor: .225,
                  heightFactor: .6,
                  child: TextField(
                    controller: TextEditingController(
                        text: storage.first.voltage.toStringAsPrecision(4)),
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
                        text: storage.first.voltage.toStringAsPrecision(4)),
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
                        text: storage.first.power.toStringAsPrecision(4)),
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
    return BaseWidget<BluetoothModel>(
      onModelReady: (bluetooth) => {},
      builder: (context, bluetooth, child) => Card(
        child: Column(
          children: <Widget>[
            BaseWidget<StorageModel>(
              onModelReady: (storage) => {},
              builder: (context, storage, child) => AdaptiveSwitchListTile(
                title: Text("Flow Sensor"),
                value: (storage.first.flowState),
                activeColor: CupertinoColors.activeGreen,
                onChanged: (changed) {
                  // for now, keep servoState line in UI. move to view model function later to incorporate bluetooth
                  if (storage.first.sysMode != 1)
                    changed
                        ? bluetooth.dataSendController.add("flow state : true")
                        : bluetooth.dataSendController.add("flow state : false");
                },
              ),
            ),
            ListTile(
              title: Text("Voltage (V)"),
              trailing: FractionallySizedBox(
                widthFactor: .225,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (storage) => {},
                  builder: (context, storage, child) => TextField(
                    controller: TextEditingController(
                        text: storage.first.voltage.toStringAsPrecision(4)),
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
                widthFactor: .225,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (storage) => {},
                  builder: (context, storage, child) => TextField(
                    controller: TextEditingController(
                        text: storage.first.flowLevel.toStringAsPrecision(4)),
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
    return BaseWidget<BluetoothModel>(
      onModelReady: (bluetooth) => {},
      builder: (context, bluetooth, child) => Card(
        child: Column(
          children: <Widget>[
            BaseWidget<StorageModel>(
              onModelReady: (storage) => {},
              builder: (context, storage, child) => AdaptiveSwitchListTile(
                title: Text("CO\u2082 Sensor"),
                value: (storage.first.co2State),
                activeColor: CupertinoColors.activeGreen,
                onChanged: (changed) {
                  // for now, keep servoState line in UI. move to view model function later to incorporate bluetooth
                  if (storage.first.sysMode != 1)
                    changed
                        ? bluetooth.dataSendController.add("co2 state : true") // TODO
                        //model.co2StatusController.add(CO2Status.Enabled)
                        : bluetooth.dataSendController
                            .add("co2 state : false");
                  //model.co2StatusController.add(CO2Status.Disabled);
                },
              ),
            ),
            ListTile(
              title: Text("CO\u2082 (%)"),
              trailing: FractionallySizedBox(
                widthFactor: .225,
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
