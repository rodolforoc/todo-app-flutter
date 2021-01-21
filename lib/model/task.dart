import 'package:flutter/foundation.dart';

class Task {
  final String id;
  final String title;
  final DateTime date;
  final String hour;
  String category;
  bool isRemindOn;
  bool isCompleted;

  Task({
    this.id,
    @required this.title,
    @required this.date,
    @required this.hour,
    this.category,
    this.isRemindOn = false,
    this.isCompleted = false,
  });

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  void toggleRemindOn() {
    isRemindOn = !isRemindOn;
  }
}
