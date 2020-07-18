import 'package:flutter/material.dart';

class SensorControlView extends StatelessWidget {
  const SensorControlView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Text("Sensor Control"),
        Stack(
          children: <Widget>[
            // Overlay(),
            // Text("Mode"),
            // ModeSelector(),
            // Text("Data"),
            // DataInfoCard(),
          ],
        ),
      ],
    );
  }
}
