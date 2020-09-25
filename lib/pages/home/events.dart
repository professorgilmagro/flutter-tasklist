import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/pages/home/components/snack.dart';
import 'package:task_app/pages/home/home.dart';

class HomeEvents {
  TextEditingController textController = TextEditingController();
  List<Task> tasks = [];
  State<Home> state;
  Map<String, dynamic> _removed = Map();

  HomeEvents(this.state);

  void save() => Task.saveAll(tasks);

  void addTaskAction() {
    if (textController.text.isEmpty) {
      return;
    }

    Task task = Task(description: textController.text, done: false);
    state.setState(() {
      tasks.add(task);
      textController.text = "";
      save();
    });
  }

  void onTaskCheck(int index, bool value) {
    state.setState(() {
      tasks[index].done = value;
      save();
    });
  }

  void onRemoveItem(index, task, context) {
    _removed["index"] = index;
    _removed["task"] = task;

    state.setState(() {
      tasks.removeAt(index);
      save();
    });

    SnackMessage(context, task.description).showUndoMessage(undoDelete);
  }

  void undoDelete() {
    state.setState(() {
      tasks.insert(_removed['index'], _removed['task']);
      save();
    });
  }

  Future<Null> onRefreshList() async {
    await Future.delayed(Duration(seconds: 1));
    state.setState(() {
      Task.sortList(tasks);
      save();
    });
  }
}
