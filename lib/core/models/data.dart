import 'dart:core';

class Data {
  final List<Datum> data;
  Data({
    this.data,
  });

  Data.initial() : data = [Datum.initial()];
  Data.value(value) : data = [Datum.value(value)];

  factory Data.fromJson(List<dynamic> parsedJson) {
    List<Datum> data = new List<Datum>();
    data = parsedJson.map((i) => Datum.fromJson(i)).toList();
    return new Data(data: data);
  }
}

class Datum {
  double co2Level;
  double flowLevel;
  double dutyCycle;
  double voltage;
  double current;
  double power;
  double pGain;
  double iGain;
  double dGain;
  bool co2State;
  bool flowState;
  bool airState;
  int sysMode;

  Datum(
      {this.co2Level,
      this.flowLevel,
      this.dutyCycle,
      this.voltage,
      this.current,
      this.power,
      this.pGain,
      this.iGain,
      this.dGain,
      this.co2State,
      this.flowState,
      this.airState,
      this.sysMode});

  Datum.initial()
      : co2Level = 0,
        flowLevel = 0,
        dutyCycle = 0,
        voltage = 0,
        current = 0,
        power = 0,
        pGain = 0,
        iGain = 0,
        dGain = 0,
        co2State = false,
        flowState = false,
        airState = false,
        sysMode = 0;

  // experimental
  Datum.value(value)
      : co2Level = value,
        flowLevel = value,
        dutyCycle = value,
        voltage = value,
        current = value,
        power = value,
        pGain = value,
        iGain = value,
        dGain = value,
        co2State = true,
        flowState = true,
        airState = true,
        sysMode = 0;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return new Datum(
      co2Level: json['CO2 level'],
      flowLevel: json['Flow level'],
      dutyCycle: json['Duty cycle'],
      voltage: json['Voltage'],
      current: json['Current'],
      power: json['Power'],
      pGain: json['Proportional gain'],
      iGain: json['Integral gain'],
      dGain: json['Derivative gain'],
      co2State: json['co2 state'],
      flowState: json['flow state'],
      airState: json['air state'],
      sysMode: json['system mode'],
    );
  }

  Map<String, dynamic> toJson() => {
        'CO2 level': co2Level,
        'Flow level': flowLevel,
        'Duty cycle': dutyCycle,
        'Voltage': voltage,
        'Current': current,
        'Power': power,
        'Proportional gain': pGain,
        'Integral gain': iGain,
        'Derivative gain': dGain,
        'co2 state': co2State,
        'flow state': flowState,
        'air state': airState,
        'system mode': sysMode, 
      };
}
