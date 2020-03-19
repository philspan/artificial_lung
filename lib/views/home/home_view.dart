import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(child: FractionallySizedBox(heightFactor: .3)),
        Flexible(
          child: FractionallySizedBox(
            heightFactor: .5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GraphContainer(),
            ),
          ),
        ),
        Flexible(
          child: FractionallySizedBox(
            heightFactor: .8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BluetoothConnectionContainer(),
            ),
          ),
        ),
      ],
    );
  }
}

class BluetoothConnectionContainer extends StatelessWidget {
  const BluetoothConnectionContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.bluetooth, size: 72),
                Text(
                  'Bluetooth Status',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "CONNECTED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}

class GraphContainer extends StatelessWidget {
  GraphContainer({Key key}) : super(key: key);

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${now.month}/${now.day}/${now.year}: ${now.minute}',
              style: TextStyle(),
            ),
          ),
          charts.BarChart([]),
        ],
      ),
    );
  }
}

/*

            charts.BarChart(
              [
                charts.Series(
                    id: "",
                    data: [],
                    domainFn: (datum, int index) {},
                    measureFn: (datum, int index) {})
              ],
            ),*/
