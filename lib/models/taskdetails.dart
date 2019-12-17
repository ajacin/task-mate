import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String columnId = '_id';
final String columntext = 'text';
final String columnCompleted = 'completed';
final String columnTaskId='taskId';

class TaskDetails {
  int id;
  String text;
  int completed;
  int taskId;

  TaskDetails({@required this.text, this.completed = 0, this.taskId});

  void toggleCompleted() {
    completed = 1-completed;
  }

  TaskDetails.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    text = map[columntext];
    completed = map[columnCompleted];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columntext: text, columnCompleted: completed};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
