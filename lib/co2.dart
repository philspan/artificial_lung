import 'package:flutter/material.dart';

class CO2SensorScreen extends StatefulWidget {
  const CO2SensorScreen({Key key}) : super(key: key);

  @override
  _CO2SensorScreenState createState() => _CO2SensorScreenState();
}

class _CO2SensorScreenState extends State<CO2SensorScreen> {
  var _taps = "disabled";
  bool _co2sensorbool = false;
  Color _currentColor = Colors.red[300];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100.0,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Co2 Sensor",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: buildCo2Switch(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Co2 %",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "%",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: _currentColor,
            child: Center(child: Text(_taps.toString(), style: TextStyle(fontSize: 18.0),)),
          ),
        ],
      ),
    );
  }

  Switch buildCo2Switch() {
    return Switch.adaptive(
        value: _co2sensorbool,
        onChanged: (bool newval) {
          setState(() {
            _co2sensorbool = newval;
            if (newval) {
              _taps = "enabled";
              _currentColor = Colors.green[300];
              // send message to enable co2 sensor
            } else if (!newval) {
              _taps = "disabled";
              _currentColor = Colors.red[300];
              // send message to disable co2 sensor
            }
          });
        });
  }
}
