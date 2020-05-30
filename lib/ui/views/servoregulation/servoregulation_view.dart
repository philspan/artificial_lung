import 'package:artificial_lung/core/viewmodels/servoregulation_viewmodel.dart';
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
    return BaseWidget<ServoRegulationViewModel>(
      onModelReady: (model) => {},
      builder: (context, model, child) => Card(
        child: Column(
          children: <Widget>[
            AdaptiveSwitchListTile(
              title: Text("CO\u2082 Servo Regulation"),
              value: model.systemMode == 1,
              activeColor: CupertinoColors.activeGreen,
              onChanged: (changed) {
                changed
                    ? model.enableServoregulation()
                    : model.enableFlowControl();
              },
            ),
            ListTile(
              title: Text("Target CO\u2082 (%)"),
              trailing: FractionallySizedBox(
                widthFactor: .225,
                heightFactor: .6,
                child: TextField(
                  controller: TextEditingController(
                      text: model
                          .co2Level //TODO change to .targetCO2 after adding to data structure (Navid)
                          .toStringAsPrecision(4)),
                  enabled: model.systemMode == 1,
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
                    print("sending target CO2 level...");
                    model.updateTargetCO2Level(value);
                    print("sent");
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("Error (%)"),
              trailing: FractionallySizedBox(
                widthFactor: .5,
                heightFactor: .6,
                child: TextField(
                  controller: TextEditingController(text: "TODO"),
                  // model.co2Level.toStringAsPrecision(4)), TODO calculate error %
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
    return BaseWidget<ServoRegulationViewModel>(
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
                widthFactor: .225,
                heightFactor: .6,
                child: TextField(
                  controller: TextEditingController(
                      text: model.pGain.toStringAsPrecision(4)),
                  enabled: model.systemMode == 1,
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
                    model.updatePGain(value);
                    print("sent");
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("Integral Term"),
              trailing: FractionallySizedBox(
                widthFactor: .225,
                heightFactor: .6,
                child: TextField(
                  enabled: model.systemMode == 1,
                  controller: TextEditingController(
                      text: model.iGain.toStringAsPrecision(4)),
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
                    print("sending I value...");
                    model.updateIGain(value);
                    print("sent");
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("Derivative Term"),
              trailing: FractionallySizedBox(
                widthFactor: .225,
                heightFactor: .6,
                child: TextField(
                  enabled: model.systemMode == 1,
                  controller: TextEditingController(
                      text: model.dGain.toStringAsPrecision(4)),
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
                    print("sending D value...");
                    model.updateDGain(value);
                    print("sent");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
