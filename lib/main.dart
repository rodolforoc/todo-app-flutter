import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/auth_screen.dart';
import 'package:todo_app/screens/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme()),
      home: AuthScreen(),
    );
  }
}
