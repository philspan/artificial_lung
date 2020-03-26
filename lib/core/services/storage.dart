import 'dart:convert';
import 'dart:io';

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

// change to class object
  Future<Map> readJSON() async {
    try {
      final file = await localFile;
      Map<String, dynamic> jsonContent = jsonDecode(file.readAsStringSync());
      return jsonContent;
    } catch (e) {
      return e;
    }
  }

// change to pass a Class type data eventually
  Future<File> writeJSON(String key, dynamic value) async {
    final file = await localFile;
    Map<String, dynamic> toJson = <String, dynamic>{
      '$key': value,
    };
    return file.writeAsString(jsonEncode(toJson), mode: FileMode.append);
  }
}
