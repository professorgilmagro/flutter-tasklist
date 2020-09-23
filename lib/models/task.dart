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

  Future<List<Task>> fetchListFromStorage() async {
    List<Task> tasks = [];

    Map<String, dynamic> data = await getStorage().getData();

    data.forEach((key, item) {
      tasks.add(Task.fromJson(item));
    });

    print('oi');
    print(data);

    return tasks;
  }

  void saveTasks(List<Task> tasks) async {
    String jsonData = json.encode(tasks);
    await getStorage().save(jsonData);
  }
}