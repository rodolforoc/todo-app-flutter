import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screens/edit_task.dart';
import './create_task.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class TodosProps {
  String title;
  Timestamp date;
  TimeOfDay hour;
  TodosProps(this.title, this.date, this.hour);
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
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

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('mytodos').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _todoList(context, snapshot.data.documents);
      },
    );
  }

  Widget _todoList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _todoListItem(context, data)).toList(),
    );
  }

  Widget _todoListItem(BuildContext context, DocumentSnapshot data) {
    final record = TodoRecord.fromSnapshot(data);

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Dismissible(
        key: ValueKey(record.title),
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
                        "Are you sure you want to delete ${record.title}?"),
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
                          deleteTodos(data.documentID);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
            return res;
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                          todo: data,
                        )));
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
                      record.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.grey[800]),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),

                  /*index == 1
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      : Container()*/
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    DateFormat.MMMEd('en_US')
                        .format(record.date.toDate())
                        .toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey[500]),
                  ),
                  Spacer(),
                  /*index == 1
                      ? Text(
                          "COMPLETED",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              color: Colors.white),
                        )
                      : */
                  Text(
                    record.hour,
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
    );
  }

  deleteTodos(item) {
    DocumentReference documentReference =
        Firestore.instance.collection("mytodos").document(item);
    documentReference.delete();
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
            _buildBody(context),
            Spacer(),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskScreen()));
        },
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

class TodoRecord {
  final String title;
  final Timestamp date;
  final String hour;
  final DocumentReference reference;

  TodoRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['date'] != null),
        assert(map['hour'] != null),
        title = map['title'],
        date = map['date'],
        hour = map['hour'];

  TodoRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  static get map => null;

  @override
  String toString() => "Record<$title:$date:$hour>";
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
