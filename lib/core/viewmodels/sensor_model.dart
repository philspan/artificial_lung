import 'dart:async';

import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/core/viewmodels/bluetooth_model.dart';
import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:artificial_lung/locator.dart';

class SensorModel extends BaseModel {
  CO2Status _co2State;
  CO2Status get co2State => _co2State;
  FlowStatus _flowState;
  FlowStatus get flowState => _flowState;
  AirStatus _airState;
  AirStatus get airState => _airState;
  ServoRegulationStatus _servoState;
  ServoRegulationStatus get servoState => _servoState;

  StreamController<CO2Status> co2StatusController =
      StreamController<CO2Status>.broadcast();
  StreamController<FlowStatus> flowStatusController =
      StreamController<FlowStatus>.broadcast();
  StreamController<AirStatus> airStatusController =
      StreamController<AirStatus>.broadcast();
  StreamController<ServoRegulationStatus> servoStatusController =
      StreamController<ServoRegulationStatus>.broadcast();

  SensorModel() {
    initState();
  }

  @override
  void dispose() {
    co2StatusController.close();
    flowStatusController.close();
    airStatusController.close();
    servoStatusController.close();
    super.dispose();
  }

  void initState() {
    co2StatusController.stream.listen((event) {
      setState(event);
    });
    flowStatusController.stream.listen((event) {
      setState(event);
    });
    airStatusController.stream.listen((event) {
      setState(event);
    });
    servoStatusController.stream.listen((event) {
      setState(event);
    });

    // initialize as completely disabled
    // later, change to get current status from device
    // initState is called on application open
    
    // change these to locator<StorageModel>.first.co2State == true for each state
    add(co2StatusController, (locator<StorageModel>().first.co2Level == 15.0) ? CO2Status.Enabled : CO2Status.Disabled);
    add(flowStatusController, (locator<StorageModel>().first.co2Level == 15.0) ? FlowStatus.Enabled : FlowStatus.Disabled);
    add(airStatusController, (locator<StorageModel>().first.co2Level == 15.0) ? AirStatus.Enabled : AirStatus.Disabled);
    add(servoStatusController, (locator<StorageModel>().first.co2Level == 0.0) ? ServoRegulationStatus.Enabled : ServoRegulationStatus.Disabled);
  }

  void setState(sensorState) {
    if (sensorState is CO2Status) {
      _co2State = sensorState;
    } else if (sensorState is FlowStatus) {
      _flowState = sensorState;
    } else if (sensorState is AirStatus) {
      _airState = sensorState;
    } else if (sensorState is ServoRegulationStatus) {
      if (sensorState == ServoRegulationStatus.Enabled) {
        // new public function to use in order to use bluetooth sends
        add(co2StatusController, CO2Status.Disabled);
        add(flowStatusController, FlowStatus.Disabled);
        add(airStatusController, AirStatus.Disabled);
        // these bypass stream update
        // setState(CO2Status.Disabled);
        // setState(FlowStatus.Disabled);
        // setState(AirStatus.Disabled);
        // these keep stream in cycle
        // co2StatusController.add(CO2Status.Disabled);
        // flowStatusController.add(FlowStatus.Disabled);
        // airStatusController.add(AirStatus.Disabled);
      }
      _servoState = sensorState;
    }
    notifyListeners();
  }

  // REQUIRES: state must be a registered state within the enum
  // EFFECTS: pushes state onto controller and writes new Datum to file.
  void add(StreamController controller, state) {
    controller.add(state);
    // add state, send data thru bluetooth, call readJSON after each update
    // locator<StorageModel>().writeJSON(Datum.value(15.0));
    //TODO convert data to be sent to string
    //TODO add data to bluetooth sendData controller
  }

  //TODO change function name? to better suit
  // used for changing PID controls and target co2, anything allowing for numeric changes sent via bt
  void sendData(String data) {
    locator<BluetoothModel>().dataSendController.add(data);
  }
}
