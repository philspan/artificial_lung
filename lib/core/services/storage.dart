import 'dart:convert';
import 'dart:io';

import 'package:artificial_lung/core/models/data.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class Storage extends ChangeNotifier {
  Storage({this.fileName});

  String fileName;

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  Future<String> _readStringFromFile() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> _writeStringToFile(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }

  Future<File> _appendStringToFile(String data) async {
    return _writeStringToFile(await _readStringFromFile() + data);
  }

  Future<List<Datum>> readDataFromFile() async {
    try {
      final List jsonContent = jsonDecode(await _readStringFromFile());
      List<Datum> data = jsonContent.map((i) => Datum.fromJson(i)).toList();
      return data;
    } catch (e) {
      if (e is FileSystemException) {
        print("FileSystemException error! Creating file...");
        // writeDataToFile(Data.initial());
        return readDataFromFile();
      }
      if (e is FormatException) {
        print("FormatException error!");
        // writeDataToFile(Data.initial());
        return readDataFromFile();
      }
      if (e is TypeError) {
        print("TypeError!");
        // writeDataToFile(Data.initial());
        return readDataFromFile();
      }
      return e;
    }
  }

  Future<File> writeDataToFile(List<Datum> data) async {
    try {
      final file = await localFile;
      return file.writeAsString(jsonEncode(data));
    } catch (e) {
      return null;
    }
  }

  Future<File> appendDatumToFile(Datum datum) async {
    var currentData = await readDataFromFile();
    currentData.insert(0, datum);
    var file = await writeDataToFile(currentData);
    return file;
  }
}
