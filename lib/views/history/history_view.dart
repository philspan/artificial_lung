import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class HistoryView extends StatelessWidget {
  const HistoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 42, 8, 8),
          child: WelcomeContainer(),
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
      child: Text("", style: TextStyle(fontSize: 24)),
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

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Today is ${now.month}/${now.day}/${now.year}. ${now.hour}:${now.minute}',
              style: TextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width * 0.9,
              child: BezierChart(
                // bezierChartScale: BezierChartScale.WEEKLY,
                // fromDate: DateTime.now(),
                // toDate: DateTime(2021),
                bezierChartScale: BezierChartScale.CUSTOM,
                xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
                series: const [
                  BezierLine(
                    lineColor: Color.fromARGB(255, 0, 39, 76),
                    data: const [
                      DataPoint<double>(value: 10, xAxis: 0),
                      DataPoint<double>(value: 130, xAxis: 5),
                      DataPoint<double>(value: 50, xAxis: 10),
                      DataPoint<double>(value: 150, xAxis: 15),
                      DataPoint<double>(value: 75, xAxis: 20),
                      DataPoint<double>(value: 0, xAxis: 25),
                      DataPoint<double>(value: 5, xAxis: 30),
                      DataPoint<double>(value: 45, xAxis: 35),
                    ],
                  ),
                ],
                config: BezierChartConfig(
                  verticalIndicatorStrokeWidth: 3.0,
                  verticalIndicatorColor: Colors.black26,
                  showVerticalIndicator: true,
                  showDataPoints: true,
                  xAxisTextStyle:
                      TextStyle(color: Color.fromARGB(255, 0, 39, 76)),
                  yAxisTextStyle:
                      TextStyle(color: Color.fromARGB(255, 0, 39, 76)),
                  displayYAxis: true,
                  stepsYAxis: 10,
                  startYAxisFromNonZeroValue: true,
                  // bubbleIndicatorColor: Color.fromARGB(255, 0, 39, 76),
                  snap: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
