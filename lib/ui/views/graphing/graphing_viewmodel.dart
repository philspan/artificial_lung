import 'package:artificial_lung/core/services/data.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:artificial_lung/core/models/data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:artificial_lung/locator.dart';
import 'package:artificial_lung/core/services/navigation.dart';

class GraphingViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _dataService = locator<DataService>();

  get chartData => _dataService.data;
  String get chartTitle => chart.seriesList[0].id;

  bool _hasSelectedValue = false;
  int _lastSelectedValue;
  int get lastSelectedChartValue => _lastSelectedValue;
  DateTime _lastSelectedTime;
  DateTime get lastSelectedChartTime => _lastSelectedTime;

  int _selectedRange = 1;
  int get selectedRange => _selectedRange;

  DateTime _maxDomainValue;
  int _maxDomainTime;

  /// Returns chart with data
  charts.TimeSeriesChart get chart {
    // create series of data using DataService
    DateTime count = DateTime.now();

    List<Node> data = [
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 0,
      ),
      Node(
        systemData: SystemData(systemMode: 0),
        timestamp: 2,
      ),
      Node(
        systemData: SystemData(systemMode: 0),
        timestamp: 3,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 4,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 5,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 6,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 7,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 8,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 9,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 10,
      ),
      Node(
        systemData: SystemData(systemMode: 0),
        timestamp: 11,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 12,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 13,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 14,
      ),
      Node(
        systemData: SystemData(systemMode: 1),
        timestamp: 15,
      ),
      Node(
        systemData: SystemData(systemMode: 0),
        timestamp: 18,
      ),
    ];

    List<charts.Series<Node, DateTime>> series = [
      charts.Series(
        id: 'System Mode',
        domainFn: (Node nodeData, _) {
          _maxDomainValue =
              count.subtract(Duration(minutes: nodeData.timestamp));
          _maxDomainTime = nodeData.timestamp;
          return count.subtract(Duration(minutes: nodeData.timestamp));
        },
        measureFn: (Node nodeData, _) => nodeData.systemData.systemMode,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFF334657)),
        data: data,
      )
    ];

    if (!_hasSelectedValue) {
      // input most recent , retrieve most recent measure
      // _lastSelectedValue =
      // series.first.measureFn(series.first.domainFn(series.first.data.last.timestamp));
      // series.first.measureFn(_maxDomainTime);
      // print(series.first.measureFn());
      _hasSelectedValue = true;
      notifyListeners();
    }

    // create chart
    return charts.TimeSeriesChart(
      series,
      animate: true,
      defaultInteractions: true,
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: (charts.SelectionModel model) {
            if (model.hasDatumSelection) {
              _lastSelectedValue = model.selectedSeries[0]
                  .measureFn(model.selectedDatum[0].index);
              _lastSelectedTime = model.selectedSeries[0].domainFn(model.selectedDatum[0].index);
              print(model.selectedSeries[0]
                  .measureFn(model.selectedDatum[0].index));
              notifyListeners(); // creates visual glitch
            }
          },
        ),
      ],
      domainAxis: charts.DateTimeAxisSpec(
        // X-axis configurations
        showAxisLine: true,
        renderSpec: charts.SmallTickRendererSpec(
          axisLineStyle: charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(Color(0xFFEDF1FA)),
            thickness: 2,
          ),
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Color(0xFF334657)),
          ),
          lineStyle: charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(Color(0xFF334657)),
          ),
        ),
        viewport: _getDateTimeRange(),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        // Y-axis configurations
        showAxisLine: true,
        renderSpec: charts.NoneRenderSpec(
          axisLineStyle: charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(Color(0xFFEDF1FA)),
            thickness: 2,
          ),
          // if GridlineRendererSpec
          // labelStyle: charts.TextStyleSpec(
          //   color: charts.ColorUtil.fromDartColor(Colors.black),
          // ),
          // lineStyle: charts.LineStyleSpec(
          //   color: charts.ColorUtil.fromDartColor(Colors.green),
          // ),
        ),
      ),
      behaviors: [
        charts.SelectNearest(eventTrigger: charts.SelectionTrigger.pressHold),
        // charts.InitialSelection(
        //     selectedDataConfig: [charts.SeriesDatumConfig("", DateTime.now())]),
      ],
    );
  }

  charts.DateTimeExtents _getDateTimeRange() {
    switch (selectedRange) {
      case 1: // 1M
        return charts.DateTimeExtents(
            start: DateTime.now().subtract(Duration(minutes: 1)),
            end: DateTime.now());
      case 2: // 15M
        return charts.DateTimeExtents(
            start: DateTime.now().subtract(Duration(minutes: 15)),
            end: DateTime.now());
      case 3: // 30M
        return charts.DateTimeExtents(
            start: DateTime.now().subtract(Duration(minutes: 30)),
            end: DateTime.now());
      case 4: // 1H
        return charts.DateTimeExtents(
            start: DateTime.now().subtract(Duration(minutes: 60)),
            end: DateTime.now());
      case 5: // 6H
        return charts.DateTimeExtents(
            start: DateTime.now().subtract(Duration(hours: 6)),
            end: DateTime.now());
      case 6: // 12H
        return charts.DateTimeExtents(
            start: DateTime.now().subtract(Duration(hours: 12)),
            end: DateTime.now());
      default:
        break;
    }
    return charts.DateTimeExtents(
        start: DateTime.now().subtract(Duration(minutes: 1)),
        end: DateTime.now());
  }

  void updateRange(int buttonIndex) {
    _selectedRange = buttonIndex;
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_dataService];

  void navigateBack() {
    _navigationService.goBack();
    // _navigationService.navigateTo(HomeRoute);
  }
}
