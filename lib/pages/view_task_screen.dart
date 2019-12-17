import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerarray/models/taskdetails.dart';

import 'package:providerarray/providers/todos_model.dart';
import 'package:providerarray/models/task.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ViewTaskScreen extends StatefulWidget {
  @override
  _ViewTaskScreenState createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Task'),
      ),
      body: Text("View this task")
    );
  }
}
