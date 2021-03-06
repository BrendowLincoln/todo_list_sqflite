import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/src/helpers/drawer_navigator.dart';
import 'package:todo_list_sqflite/src/models/category.dart';
import 'package:todo_list_sqflite/src/screens/home_screen.dart';
import 'package:todo_list_sqflite/src/services/category_services.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryServices = CategoryService();


  List<Category> _categoryList = List<Category>();

  var category;

  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryServices.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {

    category = await _categoryServices.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          category[0]['description'] ?? 'No Description';
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: [
          FlatButton(
              onPressed: (){},
              child: Text('Cancel', style: TextStyle(fontSize: 16))
          ),
          FlatButton(
              onPressed: () async {

               _category.name = _categoryNameController.text;
               _category.description = _categoryDescriptionController.text;

               var result = await _categoryServices.saveCategory(_category);
               if(result > 0) {
                 Navigator.pop(context);
                 getAllCategories();
                 _showSuccessSnackBar(Text('Category added'));
               }

              },
              child: Text('Save', style: TextStyle(fontSize: 16),)
          ),
        ],
        title: Text('Categories Form'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _categoryNameController,
                decoration: InputDecoration(
                  hintText: 'Write a category',
                  labelText: 'Category'
                ),
              ),
              TextField(
                controller: _categoryDescriptionController,
                decoration: InputDecoration(
                    hintText: 'Write a description',
                    labelText: 'Description'
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  _editFormDialog(BuildContext context) {
      return showDialog(context: context, barrierDismissible: true, builder: (param){
        return AlertDialog(
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(fontSize: 16))
            ),
            FlatButton(
                onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = _editCategoryNameController.text;
                  _category.description = _editCategoryDescriptionController.text;

                  var result = await _categoryServices.updateCategory(_category);
                  if(result > 0) {
                    print(result);
                    Navigator.pop(context);
                    getAllCategories();
                    _showSuccessSnackBar(Text('Updated'));
                  }
                  

                },
                child: Text('Update', style: TextStyle(fontSize: 16),)
            ),
          ],
          title: Text('Edit Categories Form'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _editCategoryNameController,
                  decoration: InputDecoration(
                      hintText: 'Write a category',
                      labelText: 'Category'
                  ),
                ),
                TextField(
                  controller: _editCategoryDescriptionController,
                  decoration: InputDecoration(
                      hintText: 'Write a description',
                      labelText: 'Description'
                  ),
                )
              ],
            ),
          ),
        );
      });
    }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: [
          FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(fontSize: 16))
          ),
          FlatButton(
              onPressed: () async {

                var result = await _categoryServices.deleteCategory(categoryId);
                if(result > 0) {
                  print(result);
                  Navigator.pop(context);
                  getAllCategories();
                  _showSuccessSnackBar(Text('Deleted'));
                }


              },
              child: Text('Delete', style: TextStyle(fontSize: 16),)
          ),
        ],
        title: Text('Are you sure you want to delete this?'),
      );
    });
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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Categories'),
        centerTitle: true,
      ),
      drawer: DrawerNavigator(),
      body: Center(
        child: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(icon: Icon(Icons.edit), onPressed: () {
                    _editCategory(context, _categoryList[index].id);
                  },),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList[index].name),
                      IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: (){
                        _deleteFormDialog(context, _categoryList[index].id);
                      })
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
