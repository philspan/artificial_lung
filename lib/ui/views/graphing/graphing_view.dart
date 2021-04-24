import 'package:artificial_lung/ui/views/graphing/graphing_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GraphingView extends StatelessWidget {
  const GraphingView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GraphingViewModel>.reactive(
      viewModelBuilder: () => GraphingViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(32, 40, 32, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${model.chartTitle}",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  GestureDetector(
                    onTap: () {
                      model.navigateBack();
                      print("Done tapped");
                    },
                    child: Text(
                      "Done",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(41)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(32, 28, 32, 0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${model.lastSelectedChartValue ?? ''}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Edit tapped");
                              },
                              child: Text(
                                "Edit",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${model.lastSelectedChartTime ?? ''}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Card(
                          // Chart
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 3,
                                child: model.chart,
                              ), // Chart
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: RangeSelector(),
                              ), // Chart Range Selector
                            ],
                          ),
                        ), // Chart
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Text(
                              "Highlights",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Card(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            child: Center(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RangeSelector extends ViewModelWidget<GraphingViewModel> {
  RangeSelector({Key key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, GraphingViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _RangeButton(index: 1, text: "1M"),
        _RangeButton(index: 2, text: "15M"),
        _RangeButton(index: 3, text: "30M"),
        _RangeButton(index: 4, text: "1H"),
        _RangeButton(index: 5, text: "6H"),
        _RangeButton(index: 6, text: "12H"),
      ],
    );
  }
}

class _RangeButton extends ViewModelWidget<GraphingViewModel> {
  final int index;
  final String text;

  _RangeButton({Key key, this.index, this.text})
      : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, GraphingViewModel model) {
    return GestureDetector(
      child: Card(
        color: (model.selectedRange == index)
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.primary,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 10,
          height: MediaQuery.of(context).size.height / 20,
          child: Center(
              child: Text("$text", style: Theme.of(context).textTheme.button)),
        ),
      ),
      onTap: () {
        model.updateRange(index);
      },
    );
  }
}
