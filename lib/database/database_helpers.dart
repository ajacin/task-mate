import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:providerarray/models/task.dart';

final String tableTodo = 'todo_table';
final String columnId = '_id';
final String columntitle = 'title';
final String columnCompleted = 'completed';
final String columnDate = 'date';
final String columnType = 'type';

class DatabaseHelper {
  static final _databaseName = 'TasksDatabase.db';
  static final _databaseVersion = 1;

// Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableTodo (
                $columnId INTEGER PRIMARY KEY,
                $columntitle TEXT NOT NULL,
                $columnCompleted INTEGER NOT NULL,
                $columnDate INTEGER NOT NULL
                $columnType TEXT NOT NULL
              )
              ''');
  }

  Future<int> insert(Task task) async {
    Database db = await database;
    int id = await db.insert(tableTodo, task.toMap());
    return id;
  }

  Future<Task> queryTask(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columntitle, columnCompleted, columnDate, columnType],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Task.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Task>> queryAllTasks() async {
    Database db = await database;
    List<Map> results = await db.query(tableTodo);
    List<Task> tasks = new List();
    print(results);
    results.forEach((result) {
      Task task = Task.fromMap(result);
      tasks.add(task);
    });
    return tasks;
  }

  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateNote(Task task) async {
    Database db = await database;
  return await db.update(tableTodo, task.toMap(), where: "$columnId = ?", whereArgs: [task.id]);
}

  //

}
