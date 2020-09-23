import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';

Widget TaskListView(List<Task> tasks, Function onChanged) {
  return Expanded(
    child: ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return CheckboxListTile(
            title: Text(task.description),
            value: task.done,
            secondary: CircleAvatar(
              child: Icon(task.done ? Icons.check : Icons.error),
            ),
            onChanged: onChanged,
          );
        }),
  );
}
