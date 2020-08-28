import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './create_task.dart';
import 'package:toast/toast.dart';

class TaskScreen extends StatefulWidget {
  final List taskListUpdated;

  TaskScreen({Key key, @required this.taskListUpdated}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    List myTodos = List();
    int todosCount = 0;

    setState(() {
      myTodos = widget.taskListUpdated;
      if (myTodos != null) {
        todosCount = myTodos.length;
      }
    });

    // Toast.show('Test: ' + myTodos.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Row(
          children: [
            ///Container for Content
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TASKS LIST",
                      style: TextStyle(
                          fontSize: 18,
                          height: 1.2,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueGrey[200]
                      ),
                    ),

                    ///For spacing
                    SizedBox(
                      height: 4,
                    ),

                  ///List of all the task
                    Expanded(
                      child: ListView.separated(
                      itemBuilder: (BuildContext context, index){
                        ///Change appearance of Completed Task
                        ///Say index 1 is completed
                        // .show('Test: ' + myTodos.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                        return Dismissible(
                          key: Key(myTodos[index]),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey[100]
                                ),
                                color: index == 1 ? Colors.purple[400] : Colors.transparent
                            ),
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
                                        myTodos[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: index == 1 ? Colors.white : Colors.grey[800]
                                        ),
                                      ),
                                    ),
                                    ///For Space
                                    SizedBox(width: 4,),

                                    index == 1 ? Icon(Icons.check_circle, color: Colors.white,) : Container()

                                  ],
                                ),

                                ///For Space
                                SizedBox(height: 8,),

                                ///Task Detail
                                Row(
                                  children: [
                                    Text(
                                      "18 NOV 2019",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: index == 1 ? Colors.white70 : Colors.grey[500]
                                      ),
                                    ),
                                    Spacer(),
                                    index == 1 ?
                                    Text(
                                      "COMPLETED",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 12,
                                          color: Colors.white
                                      ),
                                    ) :
                                    Text(
                                      "11:00 - 3:00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: index == 1 ? Colors.white70 : Colors.grey[500]
                                      ),
                                    ),
                                  ],
                                )
                              ],

                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, index) => Divider(height: 16, color: Colors.transparent,),
                      itemCount: todosCount,
                    ),
                  ),

                    ///For spacing
                    SizedBox(
                      height: 16,
                    ),

                    ///Button for add new task
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: Colors.purple[400],
                        child: Text(
                          "ADD NEW TASK",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => CreateTaskScreen(taskList: myTodos,)));
                        },
                      ),
                    )


                  ],
                ),
              ),
            ),

            ///Container for task categories
            Container(
              width: MediaQuery.of(context).size.width*0.22,
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
                        color: Colors.orangeAccent
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "W",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 24
                        ),
                      ),
                    ),
                  ),

                  ///More buttons
                  ///ForSpace
                  SizedBox(height: 16,),

                  ///Container for cat button
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[800]
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "F",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 24
                        ),
                      ),
                    ),
                  ),

                  ///More buttons
                  ///ForSpace
                  SizedBox(height: 16,),

                  ///Container for cat button
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[800]
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "S",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 24
                        ),
                      ),
                    ),
                  ),

                  ///More buttons
                  ///ForSpace
                  SizedBox(height: 16,),

                  ///Container for cat button
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[800]
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "P",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 24
                        ),
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
            )
          ],
        ),
      ),
    );
  }
}