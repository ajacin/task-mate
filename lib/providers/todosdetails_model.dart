import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:providerarray/models/task.dart';
import 'package:providerarray/database/database_helpers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerarray/models/taskdetails.dart';

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

class TodosDetailsModel extends ChangeNotifier{
  final List<TaskDetails> _taskdetails =[
    // TaskDetails(title: 'Finish the app'),
    // TaskDetails(title: 'Write a blog post'),
    // TaskDetails(title: 'Share with community'),
  ];

  UnmodifiableListView<TaskDetails> get allTasks =>UnmodifiableListView(_taskdetails);
  // UnmodifiableListView<TaskDetails> get incompleteTasks =>
  //     UnmodifiableListView(_taskdetails.where((todo) => todo.completed==0));
  // UnmodifiableListView<TaskDetails> get completedTasks =>
  //     UnmodifiableListView(_taskdetails.where((todo) => todo.completed==1));

  void addTaskDetail(TaskDetails taskdetails){
    _taskdetails.add(taskdetails);
    // _save(taskdetails);
    notifyListeners();
  }

  // void loadAllTasks(){
  //   print('In loadAllTasks');
  //   _readAll();
  //   notifyListeners();
  // }

  // void toggleTodo(TaskDetails taskdetails) {
  //   final taskIndex = _taskdetails.indexOf(taskdetails);
  //   _taskdetails[taskIndex].toggleCompleted();
  //   _updateNote(_taskdetails[taskIndex]);
  //   notifyListeners();
  // }

  // void deleteTodo(TaskDetails taskdetails) {
  //   _taskdetails.remove(taskdetails);
  //   _deleteNote(taskdetails.id);
  //   showToast("TaskDetails Deleted");
  //   notifyListeners();
  // }

  // _save(taskdetails) async {
  //       DatabaseHelper helper = DatabaseHelper.instance;
  //       int id = await helper.insertTaskDetail(taskdetails);
  //       showToast("TaskDetails Created");
  //       print('inserted row: $id');
  //     }

  // _read(int rowId) async {
  //       DatabaseHelper helper = DatabaseHelper.instance;
  //       //int rowId = 1;
  //       TaskDetails taskdetails = await helper.queryTask(rowId);
  //       if (taskdetails == null) {
  //       } else {
  //         return taskdetails;
  //       }
  //     }
    // _readAll() async {
    //     DatabaseHelper helper = DatabaseHelper.instance;
    //     //int rowId = 1;
    //     List list =await helper.queryAllTasks();
    //     print('about to print list');
    //     print(list);
    //     list.forEach((row) => {
    //       print(row),
    //       _taskdetails.add(row),
    //       // print(row),
    //     });
    //    notifyListeners(); 
    //   }

      // _deleteNote(int id) async {
      //   DatabaseHelper helper = DatabaseHelper.instance;
      //   //int rowId = 1;
      //   int deleteStatus =await helper.deleteNote(id);
      //   if(deleteStatus==1){
      //     print('deleted');
      //   }
        
      // }

      // _updateNote(task) async {
      //   DatabaseHelper helper = DatabaseHelper.instance;
      //   //int rowId = 1;
      //   int updateStatus =await helper.updateNote(task);
      //   if(updateStatus==1){
      //     showToast('Status of the task updated');
      //     notifyListeners();
      //   }
        
      // }
}