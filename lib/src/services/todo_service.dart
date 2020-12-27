import 'package:todo_list_sqflite/src/models/todo.dart';
import 'package:todo_list_sqflite/src/repositories/repository.dart';

class TodoService {

  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  // Create Todos
  saveTodo(Todo todo) async {
    return await _repository.insertData('todos', todo.toMap());
  }

  //Read Todos
  readTodos() async {
    return await _repository.readData('todos');
  }

}