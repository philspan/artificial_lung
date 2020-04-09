import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;

  BaseWidget({this.builder, this.onModelReady});

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseModel> extends State<BaseWidget<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider<T>.value causes memory leaks over ChangeNotifierProvider<T>
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
