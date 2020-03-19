import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artificial_lung/widgets/adaptive_switch_list_tile.dart';

class CO2SensorScreen extends StatefulWidget {
  const CO2SensorScreen({Key key}) : super(key: key);

  @override
  _CO2SensorScreenState createState() => _CO2SensorScreenState();
}

class _CO2SensorScreenState extends State<CO2SensorScreen> {
  var _co2isOn = false;
  var _flowisOn = false;
  var _airpumpisOn = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  AdaptiveSwitchListTile(
                    title: Text("CO\u2082 Sensor"),
                    value: _co2isOn,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (changed) {
                      //print("Switch changed");
                      setState(() {
                        _co2isOn = changed;
                      });
                      // Provider.of<Bluetooth>(context).initState();
                      // TODO test Bluetooth and Storage providers
                    },
                  ),
                  ListTile(
                    title: Text("CO\u2082 (%)"),
                    trailing: Text("%"),
                  ),
                ],
              ),
            ),
            Divider(),
            Card(
              child: Column(
                children: <Widget>[
                  AdaptiveSwitchListTile(
                    title: Text("Flow Sensor"),
                    value: _flowisOn,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (changed) {
                      //print("Switch changed");
                      setState(() {
                        _flowisOn = changed;
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Voltage (V)"),
                    trailing: Text(" V"),
                  ),
                  ListTile(
                    title: Text("Flow (LPM)"),
                    trailing: Text("###"),
                  ),
                ],
              ),
            ),
            Divider(),
            Card(
              child: Column(
                children: <Widget>[
                  AdaptiveSwitchListTile(
                    title: Text("Air Pump Control"),
                    value: _airpumpisOn,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (changed) {
                      //print("Switch changed");
                      setState(() {
                        _airpumpisOn = changed;
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Current (A)"),
                    trailing: Text(" A"),
                  ),
                  ListTile(
                    title: Text("Voltage (V)"),
                    trailing: Text(" V"),
                  ),
                  ListTile(
                    title: Text("Power (W)"),
                    trailing: Text(" W"),
                  ),
                  ListTile(
                    title: Text("Estimated Flow (SLPM)"),
                    trailing: Text("###"),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}