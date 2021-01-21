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

  Future<void> addTask() async {}

  Future<void> updateTask() async {}

  Future<void> deleteTask() async {}
}
