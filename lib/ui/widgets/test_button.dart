import 'dart:math';

import 'package:artificial_lung/core/models/data.dart';
import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:flutter/material.dart';

import 'base_widget.dart';

class TestButtonJSON extends StatelessWidget {
  const TestButtonJSON({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<StorageModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => GestureDetector(
        onTap: () {
          model.writeJSON(Datum.value(100 * Random().nextDouble()));
        },
        child: Container(
          color: Colors.blue[200],
          child: Text("Press"),
        ),
      ),
    );
  }
}
