import 'package:artificial_lung/ui/views/connect_device/connect_device_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:stacked/stacked.dart';

class ConnectDeviceView extends StatelessWidget {
  const ConnectDeviceView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConnectDeviceViewModel>.reactive(
      onModelReady: (model) => model.initialize(),
      viewModelBuilder: () => ConnectDeviceViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(32, 40, 32, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Connect to Device",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  GestureDetector(
                    onTap: () {
                      model.navigateToHome();
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(32, 28, 32, 0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Devices",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Column(
                              children: [
                                StreamBuilder<List<BluetoothDevice>>(
                                    stream:
                                        Stream.periodic(Duration(seconds: 2))
                                            .asyncMap(
                                                (_) => model.connectedDevices),
                                    initialData: [],
                                    builder: (c, snapshot) {
                                      return Column(
                                        children: snapshot.data
                                            .map((d) => GestureDetector(
                                                  onTap: () {
                                                    model.disconnectFromDevice(
                                                        d);
                                                    print("Disconnect: $d");
                                                  },
                                                  child: ListTile(
                                                    title: Text(d.name),
                                                    subtitle: Text(
                                                        "${d.id}, ${d.type}"),
                                                    trailing: StreamBuilder<
                                                        BluetoothDeviceState>(
                                                      stream: d.state,
                                                      initialData:
                                                          BluetoothDeviceState
                                                              .disconnected,
                                                      builder: (c, snapshot) {
                                                        if (snapshot.data ==
                                                            BluetoothDeviceState
                                                                .connected) {
                                                          return Text(
                                                              "CONNECTED");
                                                        }
                                                        return Text(snapshot
                                                            .data
                                                            .toString());
                                                      },
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      );
                                    }),
                                Divider(),
                                StreamBuilder<List<ScanResult>>(
                                  stream: model.scanResults,
                                  initialData: [],
                                  builder: (c, snapshot) => Column(
                                    children: snapshot.data
                                        .map((r) => GestureDetector(
                                              onTap: () {
                                                model.connectToDevice(r.device);
                                                print("${r.device}");
                                              },
                                              child: ListTile(
                                                title: Text(
                                                    "Device Name: ${r.device.name}"),
                                                subtitle: Text(
                                                    "${r.device.id}, ${r.device.type}"),
                                              ),
                                            ))
                                        .toList(),
                                  ),
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
    );
  }
}
