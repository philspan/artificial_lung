part of 'co2sensor_bloc.dart';

@immutable
abstract class Co2sensorState {}

class Co2sensorInitial extends Co2sensorState {}

class Co2sensorEnabled extends Co2sensorState {}

class Co2sensorDisabled extends Co2sensorState {}

class Co2sensorError extends Co2sensorState {}