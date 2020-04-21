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

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }

  Future<File> appendData(String data) async {
    return writeData(await readData() + data);
  }

  Future<Data> readJSON() async {
    try {
      final jsonContent = jsonDecode(await readData());
      return Data.fromJson(jsonContent);
    } catch (e) {
      if (e is FileSystemException) {
        print("FileSystemException error! Creating file...");
        writeJSON(Data.initial());
        return readJSON();
      }
      if (e is FormatException) {
        print("FormatException error!");
        writeJSON(Data.initial());
        return readJSON();
      }
      if (e is TypeError) {
        print("TypeError!");
        writeJSON(Data.initial());
        return readJSON();
      }
      return e;
    }
  }

  Future<File> writeJSON(Data data) async {
    try {
      final file = await localFile;
      return file.writeAsString(jsonEncode(data.data));
    } catch (e) {
      return null;
    }
  }
}
