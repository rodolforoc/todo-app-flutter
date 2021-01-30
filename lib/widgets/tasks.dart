import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/utils/app_routes.dart';
import 'package:todo_app/widgets/task_tile.dart';

class Tasks extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  Future<void> deleteTask(String id) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('tasks').doc(id);
    documentReference.delete();
  }

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
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: taskDocs.length,
                itemBuilder: (ctx, i) => TaskTile(
                  task: Task(
                    id: taskDocs[i].documentID,
                    title: taskDocs[i].get('title'),
                    date: DateTime.now(),
                    hour: taskDocs[i].get('hour'),
                    isCompleted: taskDocs[i].get('isCompleted'),
                    isRemindOn: taskDocs[i].get('isRemindOn'),
                  ),
                  userId: user.uid,
                  deleteTask: deleteTask,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: Colors.purple[400],
                child: Text(
                  "ADD NEW TASK",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.TASK_FORM,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
