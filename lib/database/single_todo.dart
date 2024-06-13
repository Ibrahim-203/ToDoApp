import 'package:hive_flutter/hive_flutter.dart';

class SingleToDo {
  List demoTask = [];

  final _myBox = Hive.box('singleList');
  void createInitialData() {
    demoTask = [
      [
        ["abc", 0]
      ]
    ];
  }

  void loadData() {
    demoTask = _myBox.get("SINGLE");
  }

  void updateDatabase() {
    _myBox.put("SINGLE", demoTask);
  }
}
