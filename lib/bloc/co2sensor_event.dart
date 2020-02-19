part of 'co2sensor_bloc.dart';

@immutable
abstract class Co2sensorEvent {}

class EnableCo2sensor extends Co2sensorEvent {}

class DisableCo2sensor extends Co2sensorEvent {}