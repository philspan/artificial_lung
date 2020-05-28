import 'dart:io';

import 'package:artificial_lung/core/enums/enums.dart';
import 'package:artificial_lung/core/services/storage.dart';
import 'package:artificial_lung/core/viewmodels/base_model.dart';
import 'package:artificial_lung/locator.dart';

import 'package:artificial_lung/core/models/data.dart';

class StorageModel extends BaseModel {
  final Storage _storage = locator<Storage>();

  StorageState _storageState = StorageState.Idle;
  StorageState get storageState => _storageState;

  // possibly change to a stream of Data
  Data dataList = Data.initial();

  // Constructor
  // On construction, this model calls a read of the file and brings data into dataList member in this class.
  StorageModel() {
    readJSON();
  }

  // setState modifies _storageState, which is used for tracking whether the file is being modified
  // Listeners are notified on return to update widgets containing data
  void setState(storageState) {
    _storageState = storageState;
    notifyListeners();
  }

  // add functions to handle getting data from list indirectly
  // TODO create getters for parts of data, rather than requiring use of dot operator
  Datum get first {
    return dataList.data.first;
  }

/*
  // readData() is a generic call to storage service to read the data from file
  // Returns success: the data contained in the file
  Future<String> _readData() async {
    setState(StorageState.Busy);
    var success = await _storage.readData();
    setState(StorageState.Idle);
    return success;
  }

  // writeData() is a generic call to storage service to write string of data to file.
  // Returns file: file path of the file written to 
  Future<File> _writeData(String data) async {
    setState(StorageState.Busy);
    File file = await _storage.writeData(data);
    setState(StorageState.Idle);
    return file;
  }
*/

  // Manages state of service while reading data from file into the class
  // Returns dataList: member of class holding parsed json data
  Future<Data> readJSON() async {
    setState(StorageState.Busy);
    dataList = await _storage.readJSON();
    setState(StorageState.Idle);
    return dataList;
  }

  // Manages state of service while writing data to file from class
  Future<File> writeJSON(Datum datum) async {
    setState(StorageState.Busy);
    dataList.data.insert(0, datum);
    var file = await _storage.writeJSON(dataList);
    setState(StorageState.Idle);
    return file;
  }
}
