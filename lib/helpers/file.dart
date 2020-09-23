import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHelper {
  String filename;
  List tasks;

  FileHelper(this.filename);

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    File file = File("${directory.path}/$filename");
    if (!file.existsSync()) {
      file.writeAsString('[]');
    }

    return file;
  }

  Future<Map<String, dynamic>> getData() async {
    try {
      File file = await getFile();
      String data = await file.readAsString();
      print(data);
      return json.decode(data);
    } catch (e) {
      return Map();
    }
  }

  Future<File> save(String content) async {
    try {
      File file = await getFile();
      return file.writeAsString(content);
    } catch (e) {
      return null;
    }
  }
}
