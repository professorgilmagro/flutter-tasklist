import 'dart:convert';

import 'package:task_app/helpers/file.dart';

class Task {
  static const FILE_STORAGE = 'data';

  FileHelper _storage;
  String description;
  bool done;

  Task({this.description, this.done});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(description: json["description"], done: json["done"] == 1);
  }

  FileHelper getStorage() {
    if (_storage == null) {
      _storage = FileHelper(FILE_STORAGE);
    }

    return _storage;
  }

  Map<String, dynamic> toJson() {
    return {'description': description, 'done': done ? 1 : 0};
  }

  static Future<List<Task>> fetchFromStorage() async {
    List<Task> tasks = [];

    String data = await Task().getStorage().getData();
    List<dynamic> jsonContent = json.decode(data);
    jsonContent.forEach((item) {
      tasks.add(Task.fromJson(item));
    });

    return tasks;
  }

  static void saveAll(List<Task> tasks) async {
    String jsonData = json.encode(tasks);
    await Task().getStorage().save(jsonData);
  }

  static void sortList(List<Task> tasks) {
    tasks.sort((a, b) {
      if (a.done && !b.done) {
        return 1;
      }

      return (!a.done && b.done) ? -1 : 0;
    });
  }
}
