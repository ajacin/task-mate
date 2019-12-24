import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:providerarray/models/task.dart';
import 'package:providerarray/database/database_helpers.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
    print(' showtostattt');
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white
      );
    }

class TodosModel extends ChangeNotifier{
  final List<Task> _tasks =[
    // Task(title: 'Finish the app'),
    // Task(title: 'Write a blog post'),
    // Task(title: 'Share with community'),
  ];

  UnmodifiableListView<Task> get allTasks =>UnmodifiableListView(_tasks);
  UnmodifiableListView<Task> get incompleteTasks =>
      UnmodifiableListView(_tasks.where((todo) => todo.completed==0));
  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((todo) => todo.completed==1));

  void addTodo(Task task){
    // _tasks.add(task);
    _save(task);
    _tasks.removeRange(0, _tasks.length-1);
    notifyListeners();
  }

  void loadAllTasks(){
    print('In loadAllTasks');
    _readAll();
    notifyListeners();
  }

  void toggleTodo(Task task) {
    print('1');
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    _updateNote(_tasks[taskIndex]);
    notifyListeners();
  }

  void deleteTodo(Task task) {
    _tasks.remove(task);
    _deleteNote(task.id);
    showToast("Task Deleted");
    notifyListeners();
  }

  _save(task) async {
        DatabaseHelper helper = DatabaseHelper.instance;
        int id = await helper.insertTask(task);
        showToast("Task Created");
        print('inserted row: $id');
        _readAll();
      }

    _readAll() async {
        DatabaseHelper helper = DatabaseHelper.instance;
        //int rowId = 1;
        List list =await helper.queryAllTasks();
        print('about to print list');
        print(list);
        list.forEach((row) => {
          print(row),
          _tasks.add(row),
          // print(row),
        });
       notifyListeners(); 
      }

      _deleteNote(int id) async {
        DatabaseHelper helper = DatabaseHelper.instance;
        //int rowId = 1;
        int deleteStatus =await helper.deleteNote(id);
        if(deleteStatus==1){
          print('deleted');
        }
        
      }

      _updateNote(task) async {
        DatabaseHelper helper = DatabaseHelper.instance;
        //int rowId = 1;
        int updateStatus =await helper.updateNote(task);
        if(updateStatus==1){
          showToast('Status of the task updated');
          notifyListeners();
        }
        
      }
}