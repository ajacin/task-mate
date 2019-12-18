import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:providerarray/models/task.dart';
import 'package:providerarray/database/database_helpers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerarray/models/taskdetails.dart';

void showToast(String message) {
  print(' showtost in taskmodel');
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white);
}

class TaskModel extends ChangeNotifier {
  Task task;

  TaskModel({this.task});

  Task get taskData => task;
  // UnmodifiableListView<TaskDetails> get incompleteTasks =>
  //     UnmodifiableListView(_taskdetails.where((todo) => todo.completed==0));
  // UnmodifiableListView<TaskDetails> get completedTasks =>
  //     UnmodifiableListView(_taskdetails.where((todo) => todo.completed==1));

  void fetchTask(int id) {
    //_taskdetails.add(taskdetails);
    // _save(taskdetails);
    print('in fetch task');
    _read(id);
    notifyListeners();
  }

  _read(int rowId) async {
    print('in read');
    DatabaseHelper helper = DatabaseHelper.instance;
    //int rowId = 1;
    Task taskreturned = await helper.queryTask(rowId);
    if (taskreturned == null) {
    } else {
      print('task returned and about to assign');
      print(taskreturned.title);
      print(taskreturned.completed);
      task = taskreturned;
      notifyListeners();
    }
  }
}
