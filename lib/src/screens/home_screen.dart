import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/src/helpers/drawer_navigator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List & SQFLite'),
        centerTitle: true,
      ),
      drawer: DrawerNavigator(),
    );
  }
}
