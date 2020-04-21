import 'dart:async';

import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/models/data.dart';
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
    co2StatusController.add(CO2Status.Disabled);
    flowStatusController.add(FlowStatus.Disabled);
    airStatusController.add(AirStatus.Disabled);
    servoStatusController.add(ServoRegulationStatus.Disabled);
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
  void add(StreamController controller, state) {
    controller.add(state);
    locator<StorageModel>().writeJSON(Datum.value(15.0));
  }
}
