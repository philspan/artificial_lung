import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/ui/views/history/history_viewmodel.dart';
import 'package:artificial_lung/ui/views/sensors/sensors_viewmodel.dart';
import 'package:artificial_lung/ui/views/servoregulation/servoregulation_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => Storage(fileName: "testFile.json"));
  locator.registerLazySingleton(
      () => Bluetooth(deviceName: "", serviceUUID: "", characteristicUUID: ""));
  locator.registerLazySingleton(() => DataService());

  locator.registerLazySingleton(() => HistoryViewModel());
  locator.registerLazySingleton(() => SensorsViewModel());
  locator.registerLazySingleton(() => ServoRegulationViewModel());
}
