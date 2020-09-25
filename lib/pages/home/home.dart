import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/pages/home/components/add.dart';
import 'package:task_app/pages/home/components/list.dart';
import 'package:task_app/pages/home/components/loading.dart';
import 'package:task_app/pages/home/components/snack.dart';
import 'package:task_app/pages/home/events.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeEvents homeEvents;

  @override
  void initState() {
    super.initState();
    this.homeEvents = HomeEvents(this);
  }

  @override
  Widget build(BuildContext context) {
    List loadingStates = [ConnectionState.none, ConnectionState.waiting];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Lista de Tarefas",
            style: GoogleFonts.poiretOne(
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 80,
        ),
        body: FutureBuilder<List>(
          future: Task.fetchFromStorage(),
          builder: (context, snapshot) {
            if (loadingStates.contains(snapshot.connectionState)) {
              return Loading(text: 'Carregando...').build();
            }

            if (snapshot.hasError) {
              String message = "Erro na obtenção dos dados!";
              SnackMessage(context, message).show();
              return Container();
            }

            homeEvents.tasks = snapshot.data;
            return Container(
              color: Colors.purple,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  AddTask.build(
                    addAction: homeEvents.addTaskAction,
                    textController: homeEvents.textController,
                  ),
                  TaskListView.build(
                    items: homeEvents.tasks,
                    onCheckboxChanged: homeEvents.onTaskCheck,
                    onRemoveItem: homeEvents.onRemoveItem,
                    onRefreshItems: homeEvents.onRefreshList,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
