import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/data.dart';
import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => Storage(fileName: "fileName.json"));
  locator.registerLazySingleton(
      () => Bluetooth(deviceName: "", serviceUUID: "", characteristicUUID: ""));
  locator.registerLazySingleton(() => DataService());
}
