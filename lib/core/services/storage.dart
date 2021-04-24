import 'dart:convert';
import 'dart:io';

import 'package:artificial_lung/core/models/data.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  Storage({this.fileName});

  String fileName;

  /// Initializes file storage by calling [localFile].
  Future initialize() async {
    final file = await localFile;
    if (!await file.exists()) {
      await _createFile();
    } else {
      await readFileAsList();
    }
  }

  /// Gets directory path where data file is stored.
  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  /// Gets filepath where data is written to.
  Future<File> get localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  /// Creates file at filepath and returns [File] object
  Future<File> _createFile([String json]) async {
    final file = await localFile;
    await file.create();
    await file.writeAsString(json ?? '');
    return file;
  }

  /// Deletes file at filepath and returns invalid [File] object
  Future<File> _deleteFile() async {
    final file = await localFile;
    await file.delete();
    return file;
  }

  /// Reads file and returns contents as string
  Future<String> _readFile() async {
    try {
      File file = await localFile;
      return await file.readAsString();
    } catch (e) {
      return e.toString();
    }
  }

  /// Writes to file given a mode and returns success
  Future<bool> _writeFile(String data, FileMode mode) async {
    try {
      File file = await localFile;
      RandomAccessFile rf = await file.open(mode: mode);
      rf.writeString(data);
      rf.flush();
      rf.close();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  /// Reads file and returns contents as List<Node>
  Future<List<Node>> readFileAsList() async {
    List<Node> data;
    while (data == null) {
      try {
        String dat = await _readFile();
        if (dat.isEmpty) return List<Node>();
        final List jsonContent = jsonDecode(await _readFile());
        data = jsonContent.map((i) => Node.fromJson(i)).toList();
        return data;
      } catch (e) {
        if (e is FileSystemException) {
          // File doesn't exist
          print("FileSystemException error! (N)");
          await _createFile();
        }
        if (e is FormatException) {
          print("FormatException error! (N)");
        }
        if (e is TypeError) {
          print("TypeError! (N)");
        }
        print(e.toString());
      }
    }
    return data;
  }

  /// Overwrites List<Node> to file.
  Future<bool> _writeListToFile(List<Node> node) async {
    try {
      return await _writeFile(jsonEncode(node), FileMode.write);
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  /// Appends Node to front of file.
  Future<bool> appendNodeToFile(Node node) async {
    try {
      if (!await (await localFile).exists()) {
        await _createFile(jsonEncode(node));
      }
      // readDataFromFile().then((value) => value.insert(0, datum));
      List<Node> currentData = await readFileAsList();
      currentData.insert(0, node);
      print(currentData.toString());
      return await _writeListToFile(currentData);
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
