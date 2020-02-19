import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'co2sensor_event.dart';
part 'co2sensor_state.dart';

class Co2sensorBloc extends Bloc<Co2sensorEvent, Co2sensorState> {
  @override
  Co2sensorState get initialState => Co2sensorInitial();

  @override
  Stream<Co2sensorState> mapEventToState(
    Co2sensorEvent event,
  ) async* {
    if (event is EnableCo2sensor) {
      yield Co2sensorEnabled();
    } else if (event is DisableCo2sensor) {
      yield Co2sensorDisabled();
    } else {
      // if device not connected / error
      yield Co2sensorError();
    }
  }
}
