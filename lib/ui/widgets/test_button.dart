import 'dart:math';

import 'package:artificial_lung/core/viewmodels/history_viewmodel.dart';
import 'package:artificial_lung/core/models/data.dart';
import 'package:flutter/material.dart';

import 'base_widget.dart';

class TestButtonJSON extends StatelessWidget {
  const TestButtonJSON({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HistoryViewModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => GestureDetector(
        onTap: () {
          model.addDatumValue(100 * Random().nextDouble());
        },
        child: Container(
          color: Colors.blue[200],
          child: Text("Press"),
        ),
      ),
    );
  }
}
