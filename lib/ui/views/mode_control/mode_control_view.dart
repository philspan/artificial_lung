import 'package:artificial_lung/ui/views/mode_control/mode_control_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class ModeControlView extends StatelessWidget {
  const ModeControlView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ModeControlViewModel>.reactive(
      builder: (context, model, child) => (model.currentMode == 0)
          ? Scaffold(
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(32, 40, 32, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Mode Control",
                          style: Theme.of(context).textTheme.headline3,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Servoregulation",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 0,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Target CO\u2082 (%)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              model.isWaiting
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onBackground,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Container(
                                                width: 68,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                child: Center(
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: model.targetCo2
                                                          .toStringAsFixed(2),
                                                    ),
                                                    decoration: null,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true,
                                                            signed: false),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      LengthLimitingTextInputFormatter(
                                                          4),
                                                      WhitelistingTextInputFormatter(
                                                          RegExp(
                                                              '^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                                                    ],
                                                    onSubmitted: (value) {
                                                      print(
                                                          "sending target CO2 level...");
                                                      model.updateTargetCo2(
                                                          double.parse(value));
                                                      print("sent");
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Error CO\u2082 (%)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Container(
                                            width: 68,
                                            height: 34,
                                            child: Center(
                                              child: Text(
                                                "${model.errorCo2.toStringAsFixed(2) ?? model.noData}${(model.errorCo2 != null) ? '%' : ''}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 0,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 8.0),
                                      Text(
                                        "Controller Tuning",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      SizedBox(height: 12),
                                      Divider(),
                                      SizedBox(height: 16.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Proportional Term",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              model.isWaiting
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onBackground,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Container(
                                                width: 68,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                child: Center(
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: model.pGainServo
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          model.noData,
                                                    ),
                                                    decoration: null,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true,
                                                            signed: false),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      LengthLimitingTextInputFormatter(
                                                          4),
                                                      WhitelistingTextInputFormatter(
                                                          RegExp(
                                                              '^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                                                    ],
                                                    onSubmitted: (value) {
                                                      model.updatePGainServo(
                                                          double.tryParse(
                                                              value));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Integral Term",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              model.isWaiting
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onBackground,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Container(
                                                width: 68,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                child: Center(
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: model.iGainServo
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          model.noData,
                                                    ),
                                                    decoration: null,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true,
                                                            signed: false),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      LengthLimitingTextInputFormatter(
                                                          4),
                                                      WhitelistingTextInputFormatter(
                                                          RegExp(
                                                              '^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                                                    ],
                                                    onSubmitted: (value) {
                                                      model.updateIGainServo(
                                                          double.tryParse(
                                                              value));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Derivative Term",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              model.isWaiting
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onBackground,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Container(
                                                width: 68,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                child: Center(
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: model.dGainServo
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          model.noData,
                                                    ),
                                                    decoration: null,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true,
                                                            signed: false),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      LengthLimitingTextInputFormatter(
                                                          4),
                                                      WhitelistingTextInputFormatter(
                                                          RegExp(
                                                              '^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                                                    ],
                                                    onSubmitted: (value) {
                                                      model.updateDGainServo(
                                                          double.tryParse(
                                                              value));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
            )
          : Scaffold(
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(32, 40, 32, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Mode Control",
                          style: Theme.of(context).textTheme.headline3,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Flow",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 0,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Target Flow Rate (LPM)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              model.isWaiting
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onBackground,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Container(
                                                width: 68,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                child: Center(
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: model.targetFlowRate
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          model.noData,
                                                    ),
                                                    decoration: null,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true,
                                                            signed: false),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      LengthLimitingTextInputFormatter(
                                                          4),
                                                      WhitelistingTextInputFormatter(
                                                          RegExp(
                                                              '^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                                                    ],
                                                    onSubmitted: (value) {
                                                      model.updateTargetFlow(
                                                          double.tryParse(
                                                              value));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Error Flow Rate (LPM)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Container(
                                            width: 68,
                                            height: 34,
                                            child: Center(
                                              child: Text(
                                                "${model.errorFlowRate ?? model.noData}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 0,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 8.0),
                                      Text(
                                        "Controller Tuning",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      SizedBox(height: 12),
                                      Divider(),
                                      SizedBox(height: 16.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Proportional Term",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              model.isWaiting
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onBackground,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Container(
                                                width: 68,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                child: Center(
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: model.pGainFlow
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          model.noData,
                                                    ),
                                                    decoration: null,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true,
                                                            signed: false),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      LengthLimitingTextInputFormatter(
                                                          4),
                                                      WhitelistingTextInputFormatter(
                                                          RegExp(
                                                              '^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                                                    ],
                                                    onSubmitted: (value) {
                                                      model.updatePGainFlow(
                                                          double.tryParse(
                                                              value));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Integral Term",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              model.isWaiting
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onBackground,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Container(
                                                width: 68,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                child: Center(
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: model.iGainFlow
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          model.noData,
                                                    ),
                                                    decoration: null,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true,
                                                            signed: false),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      LengthLimitingTextInputFormatter(
                                                          4),
                                                      WhitelistingTextInputFormatter(
                                                          RegExp(
                                                              '^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                                                    ],
                                                    onSubmitted: (value) {
                                                      model.updateIGainFlow(
                                                          double.tryParse(
                                                              value));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Derivative Term",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              model.isWaiting
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onBackground,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Container(
                                                width: 68,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                child: Center(
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: model.dGainFlow
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          model.noData,
                                                    ),
                                                    decoration: null,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true,
                                                            signed: false),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      LengthLimitingTextInputFormatter(
                                                          4),
                                                      WhitelistingTextInputFormatter(
                                                          RegExp(
                                                              '^\$|^(0|([0-9]{0,2}))(\\.[0-9]{0,3})?\$')),
                                                    ],
                                                    onSubmitted: (value) {
                                                      model.updateDGainFlow(
                                                          double.tryParse(
                                                              value));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
      viewModelBuilder: () => ModeControlViewModel(),
    );
  }
}
