import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './create_task.dart';

class TaskScreen extends StatefulWidget {
  final List<TodosProps> taskListUpdated;

  TaskScreen({Key key, @required this.taskListUpdated}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class TodosProps {
  String title;
  String date;
  String hour;
  TodosProps(this.title, this.date, this.hour);
}

class _TaskScreenState extends State<TaskScreen> {
  int todosCount = 0;

  List<TodosProps> myTodos = [];

  @override
  Widget build(BuildContext context) {
    setState(() {
      myTodos = widget.taskListUpdated;
      if (myTodos != null) {
        todosCount = myTodos.length;
      }
    });

    return Scaffold(
      body: home(context),
    );
  }

  home(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [taskList(context), categories(context)],
      ),
    );
  }

  taskList(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(context),
            SizedBox(
              height: 4,
            ),
            todoList(context),
            SizedBox(
              height: 16,
            ),
            addNewTaskButton(context)
          ],
        ),
      ),
    );
  }

  addNewTaskButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: Colors.purple[400],
        child: Text(
          "ADD NEW TASK",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w900),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateTaskScreen(
                        taskList: myTodos,
                      )));
        },
      ),
    );
  }

  todoList(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, index) {
          return Dismissible(
            key: Key(index.toString()),
            background: slideRightBackground(),
            secondaryBackground: slideLeftBackground(),
            // ignore: missing_return
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                final bool res = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "Are you sure you want to delete ${myTodos[index]}?"),
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
                            onPressed: () {
                              // TODO: Delete the item from DB etc..
                              setState(() {
                                myTodos.removeAt(index);
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                return res;
              } else {
                // TODO: Navigate to edit page;
              }
            },
            onDismissed: (direction) {
              setState(() {
                myTodos.removeAt(index);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey[100]),
                  color: index == 1 ? Colors.purple[400] : Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Show completed check
                  ///Task Title
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          myTodos[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  index == 1 ? Colors.white : Colors.grey[800]),
                        ),
                      ),

                      ///For Space
                      SizedBox(
                        width: 4,
                      ),

                      index == 1
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            )
                          : Container()
                    ],
                  ),

                  ///For Space
                  SizedBox(
                    height: 8,
                  ),

                  ///Task Detail
                  Row(
                    children: [
                      Text(
                        myTodos[index].date,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color:
                                index == 1 ? Colors.white70 : Colors.grey[500]),
                      ),
                      Spacer(),
                      index == 1
                          ? Text(
                              "COMPLETED",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  color: Colors.white),
                            )
                          : Text(
                              myTodos[index].hour,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: index == 1
                                      ? Colors.white70
                                      : Colors.grey[500]),
                            ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, index) => Divider(
          height: 16,
          color: Colors.transparent,
        ),
        itemCount: todosCount,
      ),
    );
  }

  header(BuildContext context) {
    return Text(
      "TASKS LIST",
      style: TextStyle(
          fontSize: 18,
          height: 1.2,
          letterSpacing: 1,
          fontWeight: FontWeight.w900,
          color: Colors.blueGrey[200]),
    );
  }

  categories(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      color: Colors.black,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
      child: Column(
        children: [
          ///Menu button
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),

          ///For space
          Spacer(),

          ///Container for cat button
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.orangeAccent),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                "W",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24),
              ),
            ),
          ),

          ///More buttons
          ///ForSpace
          SizedBox(
            height: 16,
          ),

          ///Container for cat button
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[800]),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                "F",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24),
              ),
            ),
          ),

          ///More buttons
          ///ForSpace
          SizedBox(
            height: 16,
          ),

          ///Container for cat button
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[800]),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                "S",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24),
              ),
            ),
          ),

          ///More buttons
          ///ForSpace
          SizedBox(
            height: 16,
          ),

          ///Container for cat button
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[800]),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                "P",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24),
              ),
            ),
          ),

          ///More buttons
          ///ForSpace
          Spacer(),

          ///Menu button
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

Widget slideRightBackground() {
  return Container(
    color: Colors.purple[400],
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
