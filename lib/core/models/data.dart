import 'dart:core';

// PID 6 values, only send 1 set each time depending on selected mode
// if marketed as product, will need sensor voltages etc for problem checking
//    dont need to track states right now on sensors.
// PID check functions and Mode verify functions
// if not in the correct mode, update mode / pid
// when updating mode signal, have to send PID values in the same string at the same time.
// either way send both co2 and flow levels
// variableName=value\r\n

// modes and targets are controlled by app to the mcu

/// Main `Node` model containing subclasses of [CO2Data], [FlowData], [SystemData], and [BatteryData].
class Node {
  static const timestampFromJson = "timestamp";
  int timestamp;
  CO2Data co2Data;
  FlowData flowData;
  SystemData systemData;
  BatteryData batteryData;

  // DateTime timestamp; // don't have gps yet. use subtraction calculations based on value to figure out when it happened
  // time receive data - time passed (number of seconds)
  // TODO TIMESTAMP find a better way to implement timestamp since mcu cant track time
  Node({
    this.timestamp,
    this.co2Data,
    this.flowData,
    this.systemData,
    this.batteryData,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      timestamp: json['$timestampFromJson'],
      co2Data: CO2Data.fromJson(json['${CO2Data.asString}']),
      flowData: FlowData.fromJson(json['${FlowData.asString}']),
      systemData: SystemData.fromJson(json['${SystemData.asString}']),
      batteryData: BatteryData.fromJson(json['${BatteryData.asString}']),
    );
  }

  Map<String, dynamic> toJson() => {
        '$timestampFromJson': timestamp,
        '${CO2Data.asString}': co2Data,
        '${FlowData.asString}': flowData,
        '${SystemData.asString}': systemData,
        '${BatteryData.asString}': batteryData,
      };
}

/// [CO2Data] model containing information related to CO2.
class CO2Data {
  static const String asString = "CO2 Data";
  static const String co2LevelFromJson = "CO2 level";
  static const String targetCo2LevelFromJson = "Target CO2 level";
  static const String pValueFromJson = "Proportional gain";
  static const String iValueFromJson = "Integral gain";
  static const String dValueFromJson = "Derivative gain";

  double co2Level; // rx
  double targetLevel; // tx and rx
  double pValue; // tx and rx
  double iValue; // tx and rx
  double dValue; // tx and rx

  CO2Data({
    this.co2Level,
    this.targetLevel,
    this.pValue,
    this.iValue,
    this.dValue,
  });

  factory CO2Data.fromJson(Map<String, dynamic> json) {
    return CO2Data(
      co2Level: json['$co2LevelFromJson'],
      targetLevel: json['$targetCo2LevelFromJson'],
      pValue: json['$pValueFromJson'],
      iValue: json['$iValueFromJson'],
      dValue: json['$dValueFromJson'],
    );
  }

  Map<String, dynamic> toJson() => {
        '$co2LevelFromJson': co2Level,
        '$targetCo2LevelFromJson': targetLevel,
        '$pValueFromJson': pValue,
        '$iValueFromJson': iValue,
        '$dValueFromJson': dValue,
      };
}

/// [FlowData] model containing information related to flow.
class FlowData {
  static const String asString = "Flow Data";
  static const String flowLevelFromJson = "Flow level";
  static const String targetFlowLevelFromJson = "Target flow level";
  static const String pValueFromJson = "Proportional gain";
  static const String iValueFromJson = "Integral gain";
  static const String dValueFromJson = "Derivative gain";
  // flow value: current flowlevel, target level (check val received is same as value sent, if not send value again)
  double flowLevel; // rx
  double targetLevel; // tx and rx
  double pValue; // tx and rx
  double iValue; // tx and rx
  double dValue; // tx and rx

  FlowData({
    this.flowLevel,
    this.targetLevel,
    this.pValue,
    this.iValue,
    this.dValue,
  });

  factory FlowData.fromJson(Map<String, dynamic> json) {
    return FlowData(
      flowLevel: json['$flowLevelFromJson'],
      targetLevel: json['$targetFlowLevelFromJson'],
      pValue: json['$pValueFromJson'],
      iValue: json['$iValueFromJson'],
      dValue: json['$dValueFromJson'],
    );
  }

  Map<String, dynamic> toJson() => {
        '$flowLevelFromJson': flowLevel,
        '$targetFlowLevelFromJson': targetLevel,
        '$pValueFromJson': pValue,
        '$iValueFromJson': iValue,
        '$dValueFromJson': dValue,
      };
}

/// [SystemData] model containing information related to the system settings.
class SystemData {
  static const String asString = "System Data";
  static const String systemModeFromJson = "system mode";
  static const String co2Mode = "0";
  static const String flowMode = "1";

  int systemMode; // tx and rx

  SystemData({
    this.systemMode,
  });

  factory SystemData.fromJson(Map<String, dynamic> json) {
    return SystemData(
      systemMode: json['$systemModeFromJson'],
    );
  }

  Map<String, dynamic> toJson() => {
        '$systemModeFromJson': systemMode,
      };
}

/// [BatteryData] model containing information related to battery health.
class BatteryData {
  // battery level (power as a percentage), battery voltage, battery current values, whether battery ischarging,
  static const String asString = "Battery Data";
  static const String batteryLevelFromJson = "battery level";
  static const String batteryVoltageFromJson = "Voltage";
  static const String batteryCurrentFromJson = "Current";
  static const String isChargingFromJson = "is charging";
  double batteryLevel;
  double batteryVoltage;
  double batteryCurrent;
  bool isCharging;

  BatteryData({
    this.batteryLevel,
    this.batteryVoltage,
    this.batteryCurrent,
    this.isCharging,
  });

  factory BatteryData.fromJson(Map<String, dynamic> json) {
    return BatteryData(
      batteryLevel: json['$batteryLevelFromJson'],
      batteryVoltage: json['$batteryVoltageFromJson'],
      batteryCurrent: json['$batteryCurrentFromJson'],
      isCharging: json['$isChargingFromJson'],
    );
  }

  Map<String, dynamic> toJson() => {
        '$batteryLevelFromJson': batteryLevel,
        '$batteryVoltageFromJson': batteryVoltage,
        '$batteryCurrentFromJson': batteryCurrent,
        '$isChargingFromJson': isCharging,
      };
}
