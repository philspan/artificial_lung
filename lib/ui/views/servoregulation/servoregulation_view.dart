import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:artificial_lung/core/viewmodels/bluetooth_model.dart';
import 'package:artificial_lung/ui/widgets/adaptive_switch_list_tile.dart';
import 'package:artificial_lung/ui/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServoRegulationView extends StatelessWidget {
  const ServoRegulationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        ServoCard(),
        PIDCard(),
      ],
    );
  }
}

class ServoCard extends StatelessWidget {
  const ServoCard({
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
                title: Text("CO\u2082 Servo Regulation"),
                value: storage.first.sysMode == 1,
                activeColor: CupertinoColors.activeGreen,
                onChanged: (changed) {
                  //TODO
                  // changed
                  //     ? model.add(model.servoStatusController,
                  //         ServoRegulationStatus.Enabled)
                  //     : model.add(model.servoStatusController,
                  //         ServoRegulationStatus.Disabled);

                  changed
                      ? bluetooth.dataSendController.add("sysMode : 0")
                      : bluetooth.dataSendController.add("sysMode : 1");
                },
              ),
              ListTile(
                title: Text("Target CO\u2082 (%)"),
                trailing: FractionallySizedBox(
                  widthFactor: .225,
                  heightFactor: .6,
                  child: BaseWidget<StorageModel>(
                    onModelReady: (storage) => {},
                    builder: (context, storage, child) => TextField(
                      controller: TextEditingController(
                          text: storage.first
                              .co2Level //TODO change to .targetCO2 after adding to data structure (Navid)
                              .toStringAsPrecision(4)),
                      enabled: storage.first.sysMode == 1,
                      decoration: InputDecoration(
                        labelText: "%",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter(
                            RegExp('^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                      ],
                      onSubmitted: (value) {
                        print("sending CO2 level...");
                        if (value != "")
                          bluetooth.dataSendController
                              .add("CO2 level : ${double.parse(value)}");
                        print("sent");
                        //TODO change false to what error handling should be
                        //TODO add targetCo2 into data structure
                      },
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text("Error (%)"),
                trailing: FractionallySizedBox(
                  widthFactor: .5,
                  heightFactor: .6,
                  child: BaseWidget<StorageModel>(
                    onModelReady: (storage) => {},
                    builder: (context, storage, child) => TextField(
                      controller: TextEditingController(text: "TODO"),
                      // storage.first.co2Level.toStringAsPrecision(4)), TODO
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "%",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter(
                            RegExp('^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                      ],
                    ),
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

class PIDCard extends StatelessWidget {
  const PIDCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BluetoothModel>(
      onModelReady: (bluetooth) => {},
      builder: (context, bluetooth, child) => Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "Controller Tuning",
                  style: TextStyle(fontSize: 18),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            ListTile(
              title: Text("Proportional Term"),
              trailing: FractionallySizedBox(
                widthFactor: .225,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (storage) => {},
                  builder: (context, storage, child) => TextField(
                    controller: TextEditingController(
                        text: storage.first.pGain.toStringAsPrecision(4)),
                    enabled: storage.first.sysMode == 1,
                    decoration: InputDecoration(
                      labelText: "Value",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(
                          RegExp('^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                    ],
                    onSubmitted: (String value) {
                      print("sending P value...");
                      if (value != "")
                        bluetooth.dataSendController
                            .add("Proportional gain : ${double.parse(value)}");
                      print("sent");
                    },
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Integral Term"),
              trailing: FractionallySizedBox(
                widthFactor: .225,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (storage) => {},
                  builder: (context, storage, child) => TextField(
                    enabled: storage.first.sysMode == 1,
                    controller: TextEditingController(
                        text: storage.first.iGain.toStringAsPrecision(4)),
                    decoration: InputDecoration(
                      labelText: "Value",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(
                          RegExp('^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                    ],
                    onSubmitted: (String value) {
                      //TODO remove logic later
                      print("sending I value...");
                      if (value != "")
                        bluetooth.dataSendController
                            .add("Integral gain : ${double.parse(value)}");
                      print("sent");
                    },
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Derivative Term"),
              trailing: FractionallySizedBox(
                widthFactor: .225,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (storage) => {},
                  builder: (context, storage, child) => TextField(
                    enabled: storage.first.sysMode == 1,
                    controller: TextEditingController(
                        text: storage.first.dGain.toStringAsPrecision(4)),
                    decoration: InputDecoration(
                      labelText: "Value",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(
                          RegExp('^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                    ],
                    onSubmitted: (String value) {
                      //TODO remove logic later
                      print("sending D value...");
                      if (value != "")
                        bluetooth.dataSendController
                            .add("Derivative gain : ${double.parse(value)}");
                      print("sent");
                    },
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
