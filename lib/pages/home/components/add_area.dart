import 'package:flutter/material.dart';

Widget AddTaskRow(Function addAction, TextEditingController textController) {
  return Container(
    padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
    child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: "Nova tarefa"),
          ),
        ),
        RaisedButton(
          onPressed: addAction,
          color: Colors.blue,
          child: Text('Criar', style: TextStyle(color: Colors.white)),
        )
      ],
    ),
  );
}
