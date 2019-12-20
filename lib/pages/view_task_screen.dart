import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerarray/models/taskdetails.dart';
import 'package:providerarray/providers/task_model.dart';

import 'package:providerarray/providers/todos_model.dart';
import 'package:providerarray/models/task.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_loader/awesome_loader.dart';

class ViewTaskScreen extends StatefulWidget {
  ViewTaskScreen({Key key, this.id}) : super(key: key);
  final int id;
  @override
  _ViewTaskScreenState createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {
  static final String path = "lib/src/pages/todo/todo_home1.dart";
  final Color color1 = Color(0XFF2B2D42);
  final Color color2 = Color(0XFF8D99AE);
  final Color color3 = Color(0XFFD1D1D1);
  final timeNow = DateTime.now().millisecondsSinceEpoch;
  final List tasks = [
    {
      "title": "Buy computer science book from Agarwal book store",
      "completed": true
    },
    {"title": "Send updated logo and source files", "completed": false},
    {"title": "Recharge broadband bill", "completed": false},
    {"title": "Pay telephone bill", "completed": false},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<TaskModel>(context, listen: false).fetchTask(widget.id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskState = Provider.of<TaskModel>(context).task;
    var deviceData = MediaQuery.of(context);
    if (taskState.title == null) {
      return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: Theme.of(context).primaryColor,
            ),
          ],
        )),
      );
    } else {
      return Scaffold(
        body: SafeArea(
            top: false,
            child: SingleChildScrollView(
                child: Column(
              children: [
                _buildHeaderPanel(),
                Container(
                  margin: EdgeInsets.all(14),
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    taskState.title,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans',
                        fontSize: 20),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(16),
                    child: Card(
                        color: timeNow > taskState.date && taskState.date != 0
                            ? (taskState.completed == 0
                                ? Colors.red[20]
                                : Colors.green[20])
                            : (taskState.completed == 0
                                ? Colors.white
                                : Colors.green[20]),
                        elevation: 5,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                leading: taskState.completed == 0
                                    ? Icon(Icons.close)
                                    : Icon(Icons.done),
                                title: taskState.completed == 0
                                    ? Text('This task is not completed')
                                    : Text('This task is completed')),
                            ListTile(
                              leading: Icon(Icons.date_range),
                              title: Text(
                                taskState.date == 0
                                    ? 'This task has no date'
                                    : DateTime.fromMillisecondsSinceEpoch(
                                            taskState.date)
                                        .toString()
                                        .substring(0, 10),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.timer),
                              title: Text(
                                taskState.date == 0
                                    ? 'This task has no time'
                                    : DateTime.fromMillisecondsSinceEpoch(
                                            taskState.date)
                                        .toString()
                                        .substring(10, 16),
                              ),
                            ),
                          ],
                        ))),
                if (taskState.type == 'text' &&
                    taskState.taskDetails.length > 0)...
                  [
                    Container(
                      color: Colors.blue,
                      child: FlutterLogo(
                        size: 60.0,
                      ),
                    ),
                  ]
                else ...
                  [
                    Container(
                      color: Colors.red,
                      child: FlutterLogo(
                        size: 60.0,
                      ),
                    ),
              ]
              ],
            ))),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            height: 50,
            child: Row(
              children: <Widget>[
                SizedBox(width: 20.0),
                IconButton(
                  color: Colors.grey.shade700,
                  icon: Icon(
                    Icons.edit,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                Spacer(),
                IconButton(
                  color: Colors.grey.shade700,
                  icon: Icon(
                    Icons.snooze,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 20.0),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          icon: taskState.completed == 0
              ? Icon(
                  Icons.done_all,
                  color: Colors.green[400],
                )
              : Icon(
                  Icons.delete,
                  color: Colors.red[400],
                ),
          label: taskState.completed == 0
              ? Text(
                  "Mark Completed",
                  style: TextStyle(color: color1),
                )
              : Text(
                  "Delete",
                  style: TextStyle(color: color1),
                ),
          onPressed: () {},
        ),
      );
    }
  }

  Container _buildHeaderPanel() {
    return Container(
      height: 80,
      padding: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color1,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Task Details',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
//  int id;
//   String title;
//   int completed;
//   int date;
//   String type;
//   List<TaskDetails> taskDetails;
