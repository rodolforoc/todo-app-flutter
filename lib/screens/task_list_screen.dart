import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskListScreen extends StatelessWidget {
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
          itemBuilder: (ctx, i) => Text('Teste'),
        );
      },
    );
  }
}
