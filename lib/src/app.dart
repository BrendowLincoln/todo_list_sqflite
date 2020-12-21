import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/src/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
