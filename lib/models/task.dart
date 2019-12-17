import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:providerarray/models/taskdetails.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String columnId = '_id';
final String columntitle = 'title';
final String columnCompleted = 'completed';
final String columnDate = 'date';
final String columnType = 'type';

class Task {
  int id;
  String title;
  int completed;
  int date;
  String type;
  List<TaskDetails> taskDetails;

  Task({@required this.title, this.completed = 0, this.date, this.type='text', this.taskDetails});

  void toggleCompleted() {
    completed = 1-completed;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columntitle];
    completed = map[columnCompleted];
    date = map[columnDate];
    type = map[columnType];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columntitle: title, columnCompleted: completed,columnDate: date, columnType:type};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
