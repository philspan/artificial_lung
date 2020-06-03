import 'dart:math';

import 'package:artificial_lung/core/viewmodels/history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';


class TestButtonJSON extends StatelessWidget {
  const TestButtonJSON({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
        builder: (context, model, child) => GestureDetector(
              onTap: () {
                model.addDatumValue(100 * Random().nextDouble());
              },
              child: Container(
                color: Colors.blue[200],
                child: Text("Press"),
              ),
            ),
        viewModelBuilder: () => HistoryViewModel());
  }
}
