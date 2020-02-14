import 'package:flutter/material.dart';

class CO2SensorScreen extends StatefulWidget {
  const CO2SensorScreen({Key key}) : super(key: key);

  @override
  _CO2SensorScreenState createState() => _CO2SensorScreenState();
}

class _CO2SensorScreenState extends State<CO2SensorScreen> {
  var _taps = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100.0,
            color: Colors.grey[100],
          ),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                color: Colors.red[300],
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _taps++;
                    });
                  },
                ),
              )),
              Container(
                width: 100.0,
                color: Colors.red,
              ),
            ],
          )),
          Container(
            height: 200.0,
            //constraints: BoxConstraints.expand(),
            color: Colors.green[300],
            child: Text(_taps.toString()),
          ),
        ],
      ),
    );
  }
}
