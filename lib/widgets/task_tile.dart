import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final String userId;

  TaskTile({
    @required this.task,
    @required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: GestureDetector(
        onDoubleTap: () {},
        child: Dismissible(
          key: ValueKey(task.id),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Are you sure you want to delete ?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    );
                  });
              return res;
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey[100]),
                color: Colors.transparent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.grey[800]),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    //record.completed == true ?
                    Icon(
                      Icons.check_circle,
                      color: Colors.purple,
                    )
                    //  : Container()
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      task.date.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.grey[500]),
                    ),
                    Spacer(),
                    task.isCompleted == true
                        ? Text(
                            "COMPLETED",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: Colors.purple),
                          )
                        : Text(
                            task.hour,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey[500]),
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
