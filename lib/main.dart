import 'package:flutter/material.dart';
import 'package:task_app/pages/home/home.dart';

void main() {
  runApp(MaterialApp(
    title: "Task List",
    home: Home(),
    theme: ThemeData(
      backgroundColor: Colors.purple,
      accentColor: Colors.purpleAccent,
      hintColor: Colors.purple,
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.purple,
        textTheme: ButtonTextTheme.accent,
      ),
      appBarTheme: AppBarTheme(
          color: Colors.purple,
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white))),
    ),
  ));
}
