import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/src/screens/categories_screen.dart';
import 'package:todo_list_sqflite/src/screens/home_screen.dart';

class DrawerNavigator extends StatefulWidget {
  @override
  _DrawerNavigatorState createState() => _DrawerNavigatorState();
}

class _DrawerNavigatorState extends State<DrawerNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlpS8SkotGxHLBiUB1KxsUQ_GacEoWfSL_ig&usqp=CAU'),
              ),
              accountName: Text('Brendow Lincoln'),
              accountEmail: Text('brendowlinconl@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categorias'),
              onTap: () => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
