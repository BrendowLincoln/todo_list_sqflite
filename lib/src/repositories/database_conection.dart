import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {

  String categoriesTable = 'categories';
  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';

  // Table todos
  String todosTable = 'todos';
  String colTitle = 'title';
  String colCategory = 'category';
  String colTodoDate = 'todo_date';
  String  colIsFinished = 'is_finished';


  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite');
    var database =
          await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute("CREATE TABLE $categoriesTable($colId INTEGER PRIMARY KEY, $colName TEXT, $colDescription TEXT)");

    // Create table  todos
    await database.execute("CREATE TABLE $todosTable($colId INTEGER PRIMARY KEY, $colTitle TEXT, $colDescription TEXT, $colCategory TEXT, $colTodoDate TEXT, $colIsFinished INTEGER)");
  }

}