import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {

  String categoriesTable = 'categories';
  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';


  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite');
    var database =
          await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute("CREATE TABLE $categoriesTable ($colId INTEGER PRIMARY KEY AUTOCOMPLETE, $colName TEXT, $colDescription)");
  }

}