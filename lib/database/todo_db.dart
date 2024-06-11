import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todolist = [];
  // reference the box
  final _myBox = Hive.box('todolist');

  void createInitialData() {
    todolist = [
      {'title': 'Jouer au basket', 'date': '2024-06-02', 'secure': false},
      {'title': 'Apprendre à coder', 'date': '2024-06-01', 'secure': true},
      {
        'title': 'Finir l\'application mobile',
        'date': '2024-06-01',
        'secure': false
      },
    ];
  }

  void loadData() {
    todolist = _myBox.get("TODOLIST");
  }

  void updateDatabase() {
    _myBox.put("TODOLIST", todolist);
  }
}
