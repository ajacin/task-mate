import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:providerarray/models/task.dart';
import 'package:providerarray/models/taskdetails.dart';

final String tableTask = 'task_table';
final String columnId = '_id';
final String columntitle = 'title';
final String columnCompleted = 'completed';
final String columnDate = 'date';
final String columnType = 'type';

final String tableTaskDetails = 'task_details_table';
final String columnTaskDetailsId = '_id';
final String columnTaskDetailsText = 'text';
final String columnTaskDetailsCompleted = 'completed';
final String columnTaskId='taskId';

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
              CREATE TABLE $tableTask (
                $columnId INTEGER PRIMARY KEY,
                $columntitle TEXT NOT NULL,
                $columnCompleted INTEGER NOT NULL,
                $columnDate INTEGER NOT NULL
                $columnType TEXT NOT NULL
              )
              ''');
    await db.execute('''
              CREATE TABLE $tableTaskDetails (
                $columnTaskDetailsId INTEGER PRIMARY KEY,
                $columnTaskDetailsText TEXT NOT NULL,
                $columnCompleted INTEGER NOT NULL,
                $columnTaskDetailsCompleted TEXT NOT NULL,
                $columnTaskDetailsId INTEGER PRIMARY KEY,
                $columnTaskId INTEGER NOT NULL,
                FOREIGN KEY($columnTaskId) REFERENCES $tableTask($columnId)
              )
              ''');
  }
  
// TASK METHODS
  Future<int> insertTask(Task task) async {
    Database db = await database;
    int id = await db.insert(tableTask, task.toMap());
    if(id>1 && task.taskDetails.length!=0){
      task.taskDetails.forEach((detail)=>{
      detail.taskId = id,
      insertTaskDetail(detail)
    });
    }
    return id;
  }

  Future<Task> queryTask(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableTask,
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
    List<Map> results = await db.query(tableTask);
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
    return await db.delete(tableTask, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateNote(Task task) async {
    Database db = await database;
  return await db.update(tableTask, task.toMap(), where: "$columnId = ?", whereArgs: [task.id]);
}

//TASKDETAILS METHODS
Future<int> insertTaskDetail(TaskDetails taskdetail) async {
    Database db = await database;
    int id = await db.insert(tableTaskDetails, taskdetail.toMap());
    return id;
  }


}
