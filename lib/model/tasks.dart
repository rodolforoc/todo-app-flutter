import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';

class Tasks {
  List<Task> _items = [];
  String _userId;

  Tasks([this._userId, this._items = const []]);

  List<Task> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadTasks() async {
    _items.clear();
  }

  Future<void> addTask(Task newTask) async {
    Map<String, dynamic> newTaskData = {
      "title": newTask.title,
      "date": newTask.date,
      "hour": newTask.hour,
      "iscompleted": newTask.isCompleted,
      "isremindon": newTask.isRemindOn,
      "userId": _userId,
    };

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('tasks').doc();
    documentReference.set(newTaskData);
  }

  Future<void> updateTask(Task task) async {}

  Future<void> deleteTask(String id) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('tasks').doc(id);
    documentReference.delete();
  }
}
