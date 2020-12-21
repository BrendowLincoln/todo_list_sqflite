import 'package:todo_list_sqflite/src/models/category.dart';

class CategoryService {
  saveCategory(Category category) {
    print(category.name);
    print(category.description);
  }
}