import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_sqflite/src/repositories/database_conection.dart';

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {

    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //Inserting data to Table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  // Read data from table
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  // Read data by id
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

    // Update data from table
  updateData(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }
}