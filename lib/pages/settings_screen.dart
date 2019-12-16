import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:providerarray/providers/todos_model.dart';
import 'package:providerarray/models/task.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final taskTitleController = TextEditingController();
  int completedStatus = 0;
  int darkMode = 0;

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  // void onAdd() {
  //   final String textVal = taskTitleController.text;
  //   final int completed = completedStatus;
  //   if (textVal.isNotEmpty) {
  //     final Task todo = Task(
  //       title: textVal,
  //       completed: completed,
  //     );
  //     Provider.of<TodosModel>(context, listen: false).addTodo(todo);
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // TextField(
                  //   controller: taskTitleController,
                  //   keyboardType: TextInputType.multiline,
                  //   maxLines: null,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     focusedBorder: InputBorder.none,
                  //     hintText: "Type your task"
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      
                      Text("Turn on dark mode theme."),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.info),
                          Switch(
                            value: darkMode == 1 ? true : false,
                            onChanged: (checked) => setState(() {
                              darkMode = checked ? 1 : 0;
                            }),
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
