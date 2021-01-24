import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/widgets/task_tile.dart';

class Tasks extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .orderBy('date')
          .snapshots(),
      builder: (ctx, taskSnapshot) {
        if (taskSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final taskDocs = taskSnapshot.data.documents;
        return ListView.builder(
          itemCount: taskDocs.length,
          itemBuilder: (ctx, i) => TaskTile(
            task: Task(
              title: taskDocs[i].get('title'),
              date: DateTime.now(),
              hour: taskDocs[i].get('hour'),
              isCompleted: taskDocs[i].get('isCompleted'),
              isRemindOn: taskDocs[i].get('isRemindOn'),
            ),
            userId: user.uid,
          ),
        );
      },
    );
  }
}
