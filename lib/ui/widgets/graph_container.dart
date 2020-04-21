import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:artificial_lung/ui/widgets/base_widget.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

class GraphContainer extends StatelessWidget {
  GraphContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return BaseWidget<StorageModel>(
      onModelReady: (model) {
        // model.readJSON();
      },
      builder: (context, model, child) => 
      Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Today is ${now.month}/${now.day}/${now.year}. ${now.hour}:${now.minute}',
                style: TextStyle(
                  fontSize: 18,
                ),
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
                  series: [
                    BezierLine(
                      lineColor: Color.fromARGB(255, 0, 39, 76),
                      data: (model.dataList.data.length < 7 || model.dataList.data == null) ? [
                        DataPoint<double>(value: 0, xAxis: 15),
                        DataPoint<double>(value: 0, xAxis: 20),
                        DataPoint<double>(value: 0, xAxis: 25),
                        DataPoint<double>(value: 0, xAxis: 30),
                        DataPoint<double>(value: 0, xAxis: 35),
                        DataPoint<double>(value: 0, xAxis: 10),
                        DataPoint<double>(value: 0, xAxis: 5),
                        DataPoint<double>(value: 0, xAxis: 0),
                        ] : [
                        DataPoint<double>(value: model.dataList.data[7].co2Level ?? 0, xAxis: 15),
                        DataPoint<double>(value: model.dataList.data[6].co2Level ?? 0, xAxis: 20),
                        DataPoint<double>(value: model.dataList.data[5].co2Level ?? 0, xAxis: 25),
                        DataPoint<double>(value: model.dataList.data[4].co2Level ?? 0, xAxis: 30),
                        DataPoint<double>(value: model.dataList.data[3].co2Level ?? 0, xAxis: 35),
                        DataPoint<double>(value: model.dataList.data[2].co2Level ?? 0, xAxis: 10),
                        DataPoint<double>(value: model.dataList.data[1].co2Level ?? 0, xAxis: 5),
                        DataPoint<double>(value: model.dataList.data[0].co2Level ?? 0, xAxis: 0),
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
                    stepsYAxis: 20,
                    startYAxisFromNonZeroValue: true,
                    // bubbleIndicatorColor: Color.fromARGB(255, 0, 39, 76),
                    snap: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
