import 'package:artificial_lung/core/viewmodels/history_viewmodel.dart';
import 'package:artificial_lung/core/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BluetoothConnectionContainer extends StatelessWidget {
  const BluetoothConnectionContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      builder: (context, model, child) => Card(
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
                  Icon(
                    Icons.bluetooth,
                    size: 72,
                  ),
                  Text(
                    'Bluetooth Status',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: model.isBusy
                      ? (CircularProgressIndicator())
                      : Text(
                          (model.bluetoothState == BluetoothStatus.Connected
                              ? "CONNECTED"
                              : "DISCONNECTED"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                ),
                color: (model.bluetoothState == BluetoothStatus.Connected)
                    ? Color(0xFF3FD89A)
                    : Color(0xFFFF535C),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HistoryViewModel(),
    );
  }
}
