import 'package:first/model/task.dart';
import 'package:first/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseServices {
  static Database? _db;
  static final DatabaseServices instance = DatabaseServices._constructor();

  final String _singleTable = "singleTask";
  final String _taskTable = "task";

  DatabaseServices._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  // function to setup our function
  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'todoDB.db');

    await deleteDatabase(databasePath);

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $_singleTable(
        id INTEGER PRIMARY KEY,
        content TEXT NOT NULL,
        status INTEGER NOT NULL,
        id_task INTEGER NOT NULL
        )
        ''');
        await db.execute('''
        CREATE TABLE $_taskTable(
        id INTEGER PRIMARY KEY,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        secure INTEGER NOT NULL,
        status INTEGER NOT NULL
        )
        ''');
      },
    );
    return database;
  }

  // Single tasks request
  void addSingleTask(String content, int id_task) async {
    final db = await database;
    await db.rawInsert('''
    INSERT INTO $_singleTable (content, status,id_task) VALUES (?,?,?)''',
        [content, 0, id_task]);
  }

  Future<List<Todo>?> getSingleTasks(int id) async {
    final db = await database;
    final data = await db.query(_singleTable, where: "id_task= ?", whereArgs: [
      id,
    ]);
    List<Todo> tasks = data
        .map((e) => Todo(
              id: e['id'] as int,
              content: e['content'] as String,
              status: e['status'] as int,
              idTask: e['id_task'] as int,
            ))
        .toList();
    return tasks;
  }

  void updateSingleTask(int id, int status) async {
    final db = await database;
    await db.update(
      _singleTable,
      {
        'status': status,
      },
      where: "id= ?",
      whereArgs: [
        id,
      ],
    );
  }

  void deleteSingleTask(int id) async {
    final db = await database;
    await db.delete(
      _singleTable,
      where: "id= ?",
      whereArgs: [
        id,
      ],
    );
  }

  // Tasks request

  void addTask(String content, String createdAt) async {
    final db = await database;
    await db.rawInsert('''
    INSERT INTO $_taskTable (content,createdAt,status,secure) VALUES (?,?,?,?)''',
        [content, createdAt, 1, 0]);
  }

  void secureTask(int id, int secure) async {
    final db = await database;
    await db.update(
      _taskTable,
      {
        'secure': secure,
      },
      where: "id= ?",
      whereArgs: [
        id,
      ],
    );
  }

  void updateTask(int id, String content) async {
    final db = await database;
    await db.update(
      _taskTable,
      {
        'content': content,
      },
      where: "id= ?",
      whereArgs: [
        id,
      ],
    );
  }

  void deleteTask(int id) async {
    final db = await database;
    await db.delete(
      _taskTable,
      where: "id= ?",
      whereArgs: [
        id,
      ],
    );
  }

  void deleteTaskTempo(int id) async {
    final db = await database;
    await db.update(
      _taskTable,
      {'status': 0},
      where: "id= ?",
      whereArgs: [
        id,
      ],
    );
  }

  Future<List<Tasks>?> getTasks() async {
    final db = await database;
    final data =
        await db.query(_taskTable, where: 'status = ?', whereArgs: [1]);

    List<Tasks> tasks = data
        .map((e) => Tasks(
              id: e['id'] as int,
              content: e['content'] as String,
              createdAt: e['createdAt'] as String,
              secure: e['secure'] as int,
              status: e['status'] as int,
            ))
        .toList();
    return tasks;
  }
}
