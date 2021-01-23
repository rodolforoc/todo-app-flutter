import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Task Tile'),
    );
  }
}
