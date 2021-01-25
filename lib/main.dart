import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/auth_screen.dart';
import 'package:todo_app/screens/create_task.dart';
import 'package:todo_app/screens/task.dart';
import 'package:todo_app/screens/task_list_screen.dart';
import 'package:todo_app/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _init = Firebase.initializeApp();

    return FutureBuilder(
      future: _init,
      builder: (ctx, appSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Todo List',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            backgroundColor: Colors.purple,
            accentColor: Colors.deepPurple[100],
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Color.fromRGBO(233, 79, 55, 1),
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          home: appSnapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Material(
                  type: MaterialType.transparency,
                  child: StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.hasData) {
                        return TaskListScreen();
                      } else {
                        return AuthScreen();
                      }
                    },
                  ),
                ),
        );
      },
    );
  }
}
