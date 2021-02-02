import 'package:flutter/material.dart';

class TaskForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Form(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                "Edit Task",
                style: TextStyle(
                    fontSize: 50,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800]),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: null,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
                onChanged: (String value) {
                  // todoTitle = value;
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[100])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[100])),
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              Container(
                child: Row(
                  children: [
                    ///Container for Icon
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(255, 240, 240, 1)),
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        icon: Icon(Icons.calendar_today),
                        color: Colors.redAccent,
                        tooltip: 'Choose a Date',
                        onPressed: () {
                          // showDatePicker(
                          //         context: context,
                          //         initialDate:
                          //             _dateTime == null ? date : _dateTime,
                          //         firstDate: DateTime(2020),
                          //         lastDate: DateTime(2220))
                          //     .then((date) => {
                          //           setState(() {
                          //             _dateTime = date;
                          //             _dateTimeString =
                          //                 DateFormat.MMMEd('en_US')
                          //                     .format(date);
                          //           })
                          //         });
                        },
                      ),
                    ),

                    ///For spacing
                    SizedBox(
                      width: 24,
                    ),

                    ///For Text
                    Text(
                      // _dateTime == null
                      //     ? DateFormat.MMMEd('en_US').format(date).toString()
                      //     : _dateTimeString,
                      '',
                      style: TextStyle(
                          fontSize: 18,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700]),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    ///Container for Icon
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(255, 250, 240, 1)),
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        icon: Icon(Icons.alarm),
                        color: Colors.orangeAccent,
                        tooltip: 'Choose a time',
                        onPressed: () {
                          // showTimePicker(
                          //   context: context,
                          //   initialTime: _time == null ? stringToTimeOfDay(time) : _time,
                          // ).then((time) => {
                          //       setState(() {
                          //         _time = time;
                          //       })
                          //     });
                        },
                      ),
                    ),

                    ///For spacing
                    SizedBox(
                      width: 24,
                    ),

                    ///For Text
                    Text(
                      // _time == null
                      //     ? stringToTimeOfDay(widget.todo["hour"]).format(context)
                      //     : _time.format(context),
                      '',
                      style: TextStyle(
                          fontSize: 18,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
