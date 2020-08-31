import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/task.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  List taskList;

  CreateTaskScreen({Key key, @required this.taskList}) : super(key: key);
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  bool remindMe = true;
  String todoTitle = "";
  DateTime _dateTime;
  TimeOfDay _time;
  String _dateTimeString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.grey[800],
        ),
        title: Text("aasdas"),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          child: createHome(context)),
    );
  }

  createHome(BuildContext context) {
    return Column(
      children: [
        title(context),
        Spacer(),
        todoInputField(context),
        Spacer(),
        todoDateField(context),
        SizedBox(
          height: 16,
        ),
        todoAlarmField(context),
        Spacer(),
        todoCategoryField(context),
        SizedBox(
          height: 16,
        ),
        todoRemindField(context),
        Spacer(),
        newTaskButton(context)
      ],
    );
  }

  title(BuildContext context) {
    return Text(
      "Create New Task",
      style: TextStyle(
          fontSize: 50,
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: Colors.grey[800]),
    );
  }

  newTaskButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: Colors.black,
        child: Text(
          "CREATE TASK",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white),
        ),
        onPressed: () {
          if (todoTitle.isEmpty) {
            widget.taskList = widget.taskList;
          } else {
            var newTodo = new TodosProps(
                todoTitle, _dateTimeString, _time.format(context));
            if (widget.taskList == null) {
              this.widget.taskList = [newTodo].toList();
            } else {
              this.widget.taskList.add(newTodo);
            }
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TaskScreen(taskListUpdated: widget.taskList)));
        },
      ),
    );
  }

  todoInputField(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.grey[800],
      ),
      onChanged: (String value) {
        todoTitle = value;
      },
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[100])),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[100])),
        hintText: "Task Name",
        hintStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  todoDateField(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ///Container for Icon
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(255, 240, 240, 1)),
            padding: const EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              color: Colors.redAccent,
              tooltip: 'Choose a Date',
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate:
                            _dateTime == null ? DateTime.now() : _dateTime,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2220))
                    .then((date) => {
                          setState(() {
                            _dateTime = date;
                            _dateTimeString =
                                DateFormat.MMMEd('en_US').format(date);
                          })
                        });
              },
            ),
          ),

          ///For spacing
          SizedBox(
            width: 24,
          ),

          ///For Text
          Text(
            _dateTime == null ? 'Choose a Date' : _dateTimeString,
            style: TextStyle(
                fontSize: 18,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700]),
          )
        ],
      ),
    );
  }

  todoAlarmField(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ///Container for Icon
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(255, 250, 240, 1)),
            padding: const EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(Icons.alarm),
              color: Colors.orangeAccent,
              tooltip: 'Choose a time',
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: _time == null ? TimeOfDay.now() : _time,
                ).then((time) => {
                      setState(() {
                        _time = time;
                      })
                    });
              },
            ),
          ),

          ///For spacing
          SizedBox(
            width: 24,
          ),

          ///For Text
          Text(
            _time == null ? 'Choose a Times' : _time.format(context),
            style: TextStyle(
                fontSize: 18,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700]),
          )
        ],
      ),
    );
  }

  todoCategoryField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey[100],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ///Container for Icon
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(255, 250, 240, 1)),
            padding: const EdgeInsets.all(16),
            child: Icon(
              Icons.web_asset,
              color: Colors.orangeAccent,
            ),
          ),

          ///For spacing
          SizedBox(
            width: 24,
          ),

          ///For Text
          Text(
            "Work",
            style: TextStyle(
                fontSize: 18,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700]),
          ),

          Spacer(),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  todoRemindField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey[100],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ///Container for Icon
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(240, 235, 255, 1)),
            padding: const EdgeInsets.all(16),
            child: Icon(
              Icons.alarm_on,
              color: Colors.purpleAccent[100],
            ),
          ),

          ///For spacing
          SizedBox(
            width: 24,
          ),

          ///For Text
          Text(
            "Remind me",
            style: TextStyle(
                fontSize: 18,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700]),
          ),

          Spacer(),
          Switch(
            onChanged: (value) {
              setState(() {
                remindMe = value;
              });
            },
            value: remindMe,
            activeColor: Colors.lightBlueAccent,
          )
        ],
      ),
    );
  }
}
