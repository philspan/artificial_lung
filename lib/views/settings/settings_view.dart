import 'package:artificial_lung/widgets/adaptive_switch_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ServoRegulationContainer(),
    );
  }
}

class ServoRegulationContainer extends StatefulWidget {
  ServoRegulationContainer({Key key}) : super(key: key);

  @override
  _ServoRegulationContainerState createState() =>
      _ServoRegulationContainerState();
}

class _ServoRegulationContainerState extends State<ServoRegulationContainer> {
  var _regulationIsOn = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              AdaptiveSwitchListTile(
                title: Text("CO\u2082 Servo Regulation"),
                value: _regulationIsOn,
                activeColor: CupertinoColors.activeGreen,
                onChanged: (changed) {
                  setState(() {
                    _regulationIsOn = changed;
                  });
                  // Provider.of<Bluetooth>(context).initState();
                  // TODO test Bluetooth and Storage providers
                },
              ),
              ListTile(
                title: Text("Target CO\u2082 (%)"),
                trailing: FractionallySizedBox(
                  widthFactor: .2,
                  heightFactor: .6,
                  child: TextField(
                    enabled: _regulationIsOn,
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
              ListTile(
                title: Text("Error (%)"),
                trailing: FractionallySizedBox(
                  widthFactor: .2,
                  heightFactor: .6,
                  child: TextField(
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
        Card(
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
                    enabled: _regulationIsOn,
                    decoration: InputDecoration(
                      labelText: "Value",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
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
                    enabled: _regulationIsOn,
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
                    enabled: _regulationIsOn,
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
      ],
    );
  }
}
