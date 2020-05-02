import 'dart:async';

import 'package:artificial_lung/core/viewmodels/bluetooth_model.dart';
import 'package:flutter/material.dart';
import 'package:artificial_lung/locator.dart';
import 'package:artificial_lung/core/services/navigation.dart';

class StartupView extends StatefulWidget {
  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sensorModel already called in constructor within locator file
    locator<BluetoothModel>().initState();
    Timer(Duration(seconds: 1),
        () => locator<NavigationService>().navigateTo(SensorsRoute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 0, 39, 76)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 70, 94, 133),
                        radius: 50.0,
                        child: Icon(
                          Icons.whatshot,
                          color: Color.fromARGB(255, 255, 205, 3),
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Servoregulator",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
