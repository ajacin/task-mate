import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String columnId = '_id';
final String columntitle = 'title';
final String columnCompleted = 'completed';
final String columnDate = 'date';

class Task {
  int id;
  String title;
  int completed;
  int date;

  Task({@required this.title, this.completed = 0, this.date});

  void toggleCompleted() {
    completed = 1-completed;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columntitle];
    completed = map[columnCompleted];
    date = map[columnDate];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columntitle: title, columnCompleted: completed,columnDate: date};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
