import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/pages/home/components/add_area.dart';
import 'package:task_app/pages/home/components/list_area.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TextEditingController taskFieldControl = TextEditingController();
  List<Task> _tasks = [];

  void _addTaskAction() {
    Task task = Task(description: taskFieldControl.text, done: false);
    setState(() {
      _tasks.add(task);
      taskFieldControl.text = "";
      task.saveTasks(_tasks);
    });
  }

  void _onTaskCheck(bool value) {
    setState(() {
      _tasks[0].done = value;
      Task().saveTasks(_tasks);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Task().fetchListFromStorage().then((tasks) => this._tasks = tasks);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          AddTaskRow(_addTaskAction, taskFieldControl),
          TaskListView(_tasks, _onTaskCheck),
        ],
      ),
    );
  }
}
