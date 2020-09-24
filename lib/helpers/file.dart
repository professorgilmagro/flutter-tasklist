import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHelper {
  String filename;
  List tasks;
  File _file;

  FileHelper(this.filename);

  Future<File> getFile() async {
    if (_file != null) {
      return _file;
    }

    final directory = await getApplicationDocumentsDirectory();

    File file = File("${directory.path}/$filename");
    if (!file.existsSync()) {
      file.writeAsString('[]');
    }

    _file = file;
    return _file;
  }

  Future<String> getData() async {
    File file = await getFile();
    return await file.readAsString();
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
