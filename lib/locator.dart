import 'package:artificial_lung/core/services/bluetooth.dart';
import 'package:artificial_lung/core/services/navigation.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/core/viewmodels/bluetooth_model.dart';
import 'package:artificial_lung/core/viewmodels/storage_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => Storage(fileName: "text.txt"));
  locator.registerLazySingleton(
      () => Bluetooth(deviceName: "", serviceUUID: "", characteristicUUID: ""));

  locator.registerLazySingleton(() => BluetoothModel());
  locator.registerLazySingleton(() => StorageModel());
}
