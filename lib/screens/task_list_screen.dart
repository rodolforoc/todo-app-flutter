import 'package:flutter/material.dart';
import 'package:todo_app/widgets/tasks.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bem vindo",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.2,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueGrey[200],
                    ),
                  ),
                  Expanded(
                    child: Tasks(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
