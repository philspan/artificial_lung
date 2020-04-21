import 'package:artificial_lung/ui/widgets/bluetooth_container.dart';
import 'package:artificial_lung/ui/widgets/graph_container.dart';
import 'package:flutter/material.dart';

import 'package:artificial_lung/ui/widgets/test_button.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 42, 8, 8),
          child: TestButtonJSON(),
        ),
        GraphContainer(),
        AspectRatio(
          aspectRatio: 1 / .47,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BluetoothConnectionContainer(),
          ),
        ),
      ],
    );
  }
}

class WelcomeContainer extends StatelessWidget {
  const WelcomeContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text("Servoregulator", style: TextStyle(fontSize: 24)),
    );
  }
}

