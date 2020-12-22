import 'package:todo_list_sqflite/src/models/category.dart';
import 'package:todo_list_sqflite/src/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  //Create data
  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.toMap());
  }

  readCategories() async {
    return await _repository.readData('categories');
  }
}