import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerarray/models/taskdetails.dart';
import 'package:providerarray/providers/task_model.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Provider.of<TaskModel>(context, listen: false).fetchTask(1));
  }
  @override
  Widget build(BuildContext context) {
    final taskState = Provider.of<TaskModel>(context);
    return Container(child: Text(
      taskState.taskData.taskDetails[0].text
    ),);
  }
}
//  int id;
//   String title;
//   int completed;
//   int date;
//   String type;
//   List<TaskDetails> taskDetails;