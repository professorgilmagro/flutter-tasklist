import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/models/task.dart';

class TaskListView {
  List<Task> tasks;
  Function onCheckboxChanged;
  Function onRemoveItem;
  Function onRefreshItems;

  TaskListView(
      {@required this.tasks,
      @required this.onCheckboxChanged,
      @required this.onRemoveItem,
      @required this.onRefreshItems});

  static Widget build(
      {items, onCheckboxChanged, onRemoveItem, onRefreshItems}) {
    return TaskListView(
            tasks: items,
            onRefreshItems: onRefreshItems,
            onCheckboxChanged: onCheckboxChanged,
            onRemoveItem: onRemoveItem)
        .view();
  }

  Widget view() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefreshItems,
        child: Card(
          color: tasks.isEmpty ? Colors.purple : Colors.white,
          elevation: 0.1,
          margin: EdgeInsets.only(top: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: buildContent(),
        ),
      ),
    );
  }

  Widget buildContent() {
    if (tasks.isEmpty) {
      return buildEmptyContentView();
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        Task task = tasks[index];
        return buildItem(context, index, task);
      },
    );
  }

  Widget buildEmptyContentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.tag_faces,
          size: 120,
          color: Colors.white,
        ),
        Divider(),
        Text(
          'Nenhuma tarefa pendente!',
          style: GoogleFonts.pompiere(fontSize: 26, color: Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget buildItem(context, int index, Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (dismiss) {
        return onRemoveItem(index, task, context);
      },
      background: Container(
        color: Colors.deepPurple,
        child: Container(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.white),
              Text(' Remover item',
                  style: GoogleFonts.poiretOne(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(task.description,
            style: GoogleFonts.pompiere(
              fontSize: 26,
              color: Colors.purple,
              decoration: task.done ? TextDecoration.lineThrough : null,
            )),
        value: task.done,
        checkColor: Colors.white,
        secondary: CircleAvatar(
          backgroundColor: Colors.purple,
          child: Icon(
            task.done ? Icons.check : Icons.watch_later,
            color: Colors.white,
          ),
        ),
        onChanged: (value) {
          return onCheckboxChanged(index, value);
        },
      ),
    );
  }
}
