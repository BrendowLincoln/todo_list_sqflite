import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/src/helpers/drawer_navigator.dart';
import 'package:todo_list_sqflite/src/services/category_services.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  var todoTitleController = TextEditingController();

  var todoDescriptionController = TextEditingController();

  var todoDateController = TextEditingController();

  var _selectedValue;

  var _categories = List<DropdownMenuItem>();


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Write Todo Title'
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Write Todo Description'
              ),
            ),
            TextField(
              controller: todoDateController,
              decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Pick a Date',
                  prefixIcon: InkWell(
                    onTap: () {},
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
              onPressed: (){},
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
