import 'package:todo_list_sqflite/src/models/category.dart';
import 'package:todo_list_sqflite/src/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  // Save the category data
  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.toMap());
  }

  // Read all categories data
  readCategories() async {
    return await _repository.readData('categories');
  }

  // Read category by id
  readCategoryById(categoryId) async {
    return await _repository.readDataById('categories', categoryId);
  }
}