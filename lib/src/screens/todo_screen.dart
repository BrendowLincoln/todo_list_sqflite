import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/src/models/todo.dart';
import 'package:todo_list_sqflite/src/services/category_services.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_sqflite/src/services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  var _todoTitleController = TextEditingController();

  var _todoDescriptionController = TextEditingController();

  var _todoDateController = TextEditingController();

  var _selectedValue;

  var _categories = List<DropdownMenuItem>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category){
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickdDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100)
    );

    if(_pickdDate !=  null) {
      setState(() {
        _dateTime = _pickdDate;
        _todoDateController.text = DateFormat('dd/MM/yyyy').format(_pickdDate);
      });
    }

  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message, backgroundColor: Theme.of(context).primaryColor,);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _todoTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Write Todo Title'
              ),
            ),
            TextField(
              controller: _todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Write Todo Description'
              ),
            ),
            TextField(
              controller: _todoDateController,
              decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Pick a Date',
                  prefixIcon: InkWell(
                    onTap: () => _selectedTodoDate(context),
                    child: Icon(Icons.calendar_today),
                  ),
              ),
            ),
           DropdownButtonFormField(
             value: _selectedValue,
             items: _categories,
             onChanged: (value) {
               setState(() {
                 _selectedValue = value;
               });
             },
             hint: Text('Category'),
           ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                var todoObject = Todo();

                todoObject.title = _todoTitleController.text;
                todoObject.description = _todoDescriptionController.text;
                todoObject.todoDate = _todoDateController.text;
                todoObject.category = _selectedValue.toString();
                todoObject.isFinished = 0;

                var _todoService = TodoService();
                var result = await _todoService.saveTodo(todoObject);

                if(result > 0) {
                  _showSuccessSnackBar(Text('Created Todo'));
                }

                print(result);
              },
              color: Colors.deepOrange,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
