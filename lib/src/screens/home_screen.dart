import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/src/helpers/drawer_navigator.dart';
import 'package:todo_list_sqflite/src/models/todo.dart';
import 'package:todo_list_sqflite/src/screens/todo_screen.dart';
import 'package:todo_list_sqflite/src/services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TodoService _todoService;

  List<Todo> _todoList = List<Todo>();


  @override
  void initState() {
    super.initState();
    setState(() {
      getAllTodos();
    });
  }

  getAllTodos() async {
    _todoService = TodoService();
    _todoList = List<Todo>();

    var   todos = await _todoService.readTodos();

    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todo_date'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List & SQFLite'),
        centerTitle: true,
      ),
      drawer: DrawerNavigator(),
      body: ListView.builder(
        itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_todoList[index].title ?? 'No title')
                    ],
                  ),
                  subtitle: Text(_todoList[index].category ?? 'No category'),
                  trailing: Text(_todoList[index].todoDate ?? 'No Date'),
                ),
              ),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TodoScreen())),
        child: Icon(Icons.add),
      ),
    );

  }
}
