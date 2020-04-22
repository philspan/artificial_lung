import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/core/viewmodels/sensor_model.dart';
import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:artificial_lung/locator.dart';
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
    return BaseWidget<SensorModel>(
      onModelReady: (model) => {},
      builder: (context, model, child) => Card(
        child: Column(
          children: <Widget>[
            AdaptiveSwitchListTile(
              title: Text("CO\u2082 Servo Regulation"),
              value: model.servoState == ServoRegulationStatus.Enabled,
              activeColor: CupertinoColors.activeGreen,
              onChanged: (changed) {
                changed
                    ? model.add(model.servoStatusController,
                        ServoRegulationStatus.Enabled)
                    : model.add(model.servoStatusController,
                        ServoRegulationStatus.Disabled);
              },
            ),
            ListTile(
              title: Text("Target CO\u2082 (%)"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: TextField(
                  enabled: model.servoState == ServoRegulationStatus.Enabled,
                  decoration: InputDecoration(
                    labelText: "%",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  onSubmitted: (value) {
                    locator<Storage>().writeData(value);
                    locator<Storage>().readData().then((valFromFile) {
                      // error = valFromFile;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("Error (%)"),
              trailing: FractionallySizedBox(
                widthFactor: .5,
                heightFactor: .6,
                child: BaseWidget<StorageModel>(
                  onModelReady: (model) => {},
                  builder: (context, model, child) => TextField(
                    controller: TextEditingController(
                        text:
                            "TODO"), // model.first.co2Level.toStringAsPrecision(4)),
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

class PIDCard extends StatelessWidget {
  const PIDCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SensorModel>(
      onModelReady: (model) => {},
      builder: (context, model, child) => Card(
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
                widthFactor: .2,
                heightFactor: .6,
                child: TextField(
                  controller: TextEditingController(
                      text: locator<StorageModel>()
                          .first
                          .pGain
                          .toStringAsPrecision(4)),
                  enabled: model.servoState == ServoRegulationStatus.Enabled,
                  decoration: InputDecoration(
                    labelText: "Value",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (String text) {},
                ),
              ),
            ),
            ListTile(
              title: Text("Integral Term"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: TextField(
                  enabled: model.servoState == ServoRegulationStatus.Enabled,
                  controller: TextEditingController(
                      text: locator<StorageModel>()
                          .first
                          .iGain
                          .toStringAsPrecision(4)),
                  decoration: InputDecoration(
                    labelText: "Value",
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
              title: Text("Derivative Term"),
              trailing: FractionallySizedBox(
                widthFactor: .2,
                heightFactor: .6,
                child: TextField(
                  enabled: model.servoState == ServoRegulationStatus.Enabled,
                  controller: TextEditingController(
                      text: locator<StorageModel>()
                          .first
                          .dGain
                          .toStringAsPrecision(4)),
                  decoration: InputDecoration(
                    labelText: "Value",
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
    );
  }
}
