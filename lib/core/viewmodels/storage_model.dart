import 'dart:io';

import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

import 'package:artificial_lung/core/models/datum.dart';

class StorageModel extends BaseModel {
  final Storage _storage = locator<Storage>();

  // add functions to handle getting data from list indirectly
  Data dataList;

  StorageModel () {
    readJSON();
  }

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

  Future<Data> readJSON() async {
    setState(ViewState.Busy);
    dataList = await _storage.readJSON();
    setState(ViewState.Idle);
    print(dataList.data[0].co2Level);
    print(dataList.data.length);
    return dataList;
  }

  Future<File> writeJSON(Datum datum) async {
    setState(ViewState.Busy);
    dataList.data.insert(0, datum);
    var file = await _storage.writeJSON(dataList);
    setState(ViewState.Idle);
    return file;
  }
}
