import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget AddTaskRow(Function addAction, TextEditingController textController) {
  return Padding(
    padding: EdgeInsets.all(6),
    child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: textController,
            style: GoogleFonts.adventPro(
              textStyle: TextStyle(color: Colors.white, fontSize: 20),
            ),
            decoration: InputDecoration(
              labelText: "Nova tarefa",
              labelStyle: GoogleFonts.adventPro(
                textStyle: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        FloatingActionButton(
          elevation: 0,
          onPressed: addAction,
          backgroundColor: Colors.purple[600],
          mini: false,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}
