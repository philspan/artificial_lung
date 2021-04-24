import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  const StatusIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 19,
      decoration: BoxDecoration(
        color: Theme.of(context).indicatorColor,
        border:
            Border.all(width: 1.0, color: Theme.of(context).backgroundColor),
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
