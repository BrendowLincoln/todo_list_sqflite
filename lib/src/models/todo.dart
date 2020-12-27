class Todo {

  int id;
  String title;
  String description;
  String category;
  String todoDate;
  int isFinished;

  toMap(){
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['todo_date'] = todoDate;
    map['is_finished'] = isFinished;
    return map;
  }
}