import 'dart:io';

import 'package:artificial_lung/core/enums/viewstate.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

class StorageModel extends BaseModel {
  final Storage _storage = locator<Storage>();
  
  Future<String> readData() async {
    setState(ViewState.Busy);
    var success = await _storage.readData();
    setState(ViewState.Idle);
    return success;
  }

  Future<File> writeData(String data) async {
    setState(ViewState.Busy);
    File file = await _storage.writeData(data);
    setState(ViewState.Idle);
    return file;
  }

  Future<Map> readJSON() async {
    setState(ViewState.Busy);
    var jsonMap = await _storage.readJSON();
    setState(ViewState.Idle);
    return jsonMap;
  }

  Future<File> writeJSON(String key, dynamic value) async {
    setState(ViewState.Busy);
    var file = await _storage.writeJSON(key, value);
    setState(ViewState.Idle);
    return file;
  }
}