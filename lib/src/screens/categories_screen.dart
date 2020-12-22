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


    @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
      _categoryList = List<Category>();
      var categories = await _categoryServices.readCategories();
      categories.forEach((category){
        setState(() {
          var categoryModel = Category();
          categoryModel.name = category['name'];
          categoryModel.description = category['description'];
          categoryModel.id = category['id'];
          _categoryList.add(categoryModel);
        });
      });
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
               print(result);

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  leading: IconButton(icon: Icon(Icons.edit), onPressed: () {},),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList[index].name),
                      IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: (){})
                    ],
                  ),
                  subtitle: Text(_categoryList[index].description),
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
