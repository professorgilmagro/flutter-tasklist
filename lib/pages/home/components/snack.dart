import 'package:flutter/material.dart';

void SnackUndoMessage(context, String description, Function onUndoPressed) {
  SnackBarAction barAction = SnackBarAction(
    label: "Desfazer",
    onPressed: onUndoPressed,
  );

  Widget message = RichText(
    text: TextSpan(
      text: 'Tarefa ',
      style: TextStyle(color: Colors.white),
      children: <TextSpan>[
        TextSpan(
            text: description,
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.amber)),
        TextSpan(text: ' removida!'),
      ],
    ),
  );

  SnackMessage(context, message, barAction: barAction);
}

void SnackMessage(context, Widget content,
    {SnackBarAction barAction, int seconds}) {
  SnackBar snack = SnackBar(
      duration: Duration(seconds: seconds ?? 4),
      content: content,
      backgroundColor: Colors.deepPurple,
      action: barAction);

  Scaffold.of(context).removeCurrentSnackBar();
  Scaffold.of(context).showSnackBar(snack);
}
