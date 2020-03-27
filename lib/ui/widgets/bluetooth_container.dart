import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/viewmodels/bluetooth_model.dart';
import 'package:artificial_lung/ui/views/baseview/base_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BluetoothConnectionContainer extends StatelessWidget {
  const BluetoothConnectionContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<BluetoothStatus>(context);

    return BaseView<BluetoothModel>(
      onModelReady: (model) => {},
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
                  Icon(Icons.bluetooth, size: 72),
                  Text(
                    'Bluetooth Status',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: model.viewState == ViewState.Busy
                      ? (CircularProgressIndicator())
                      : Text(
                          (connectionStatus  == BluetoothStatus.Connected) ? "CONNECTED" : "DISCONNECTED",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                ),
                color: (connectionStatus  == BluetoothStatus.Connected) ? Colors.green : Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}