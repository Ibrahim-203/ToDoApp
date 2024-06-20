import 'package:first/services/database_services.dart';

class SingleToDo {
  void addSingleTask(String content, int id_task) async {
    DatabaseServices data = DatabaseServices.instance;
    final db = await data.database;
    await db.rawInsert('''
    INSERT INTO singleTask (content, status,id_task) VALUES (?,?,?)''',
        [content, 0, id_task]);
  }
}
