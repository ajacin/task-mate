import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerarray/models/taskdetails.dart';

import 'package:providerarray/providers/todos_model.dart';
import 'package:providerarray/models/task.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final taskTitleController = TextEditingController();
  int completedStatus = 0;
  int _timedTask = 0;
  String _date = "Today";
  String _time = "No Time";
  bool _validateTitle = false;
  DateTime datetime = DateTime.now();
  TimeOfDay timeofday =
      TimeOfDay(hour: 23, minute: 59);

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = taskTitleController.text;
    final int completed = completedStatus;
    if (textVal.isNotEmpty) {
      datetime = DateTime(datetime.year, datetime.month, datetime.day,
          timeofday.hour, timeofday.minute, 0);
      int calculatedTime = datetime.millisecondsSinceEpoch;
      final _timeOfTask = _timedTask == 1 ? calculatedTime : 0;
      final List<TaskDetails> _taskdetail = [];
      _taskdetail.add(TaskDetails(text:'taskdetailstexthuha',completed: 0));//explore addAll method
      final Task task =
          Task(title: textVal, completed: completed, date: _timeOfTask, type:'text', taskDetails: _taskdetail);
      print('timeoftask $_timeOfTask');
      Provider.of<TodosModel>(context, listen: false).addTodo(task);
      Navigator.pop(context);
    }
    else{
      setState(() {
                  _validateTitle=true;
                });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: taskTitleController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: InputBorder.none,
                        errorText: _validateTitle ? 'Enter a title' : null,
                        hintText: "Task title"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Mark this task completed?"),
                      Switch(
                        value: completedStatus == 1 ? true : false,
                        onChanged: (checked) => setState(() {
                          completedStatus = checked ? 1 : 0;
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Does this task have a time?"),
                      Switch(
                        value: _timedTask == 1 ? true : false,
                        onChanged: (checked) => setState(() {
                          _timedTask = checked ? 1 : 0;
                        }),
                      ),
                    ],
                  ),

                  Visibility(
                    visible: _timedTask==1?true:false,
                    child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          size: 25.0,
                                        ),
                                        Text(
                                          " $_date",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        FlatButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.update),
                              Text("Set a date")
                            ],
                          ),
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2099, 12, 31),
                                onConfirm: (date) {
                              print('confirm $date');
                              datetime = date;
                              _date =
                                  '${date.day} / ${date.month} / ${date.year}';
                              setState(() {});
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                        ),
                      ],
                    ),
                  ),
                  ),
                  Visibility(
                    visible: _timedTask==1?true:false,
                    child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.access_time,
                                          size: 25.0,
                                        ),
                                        Text(
                                          " $_time",
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        FlatButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.update),
                              Text("Set a time")
                            ],
                          ),
                          onPressed: () {
                            DatePicker.showTimePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true, onConfirm: (time) {
                              print('confirm $time');
                              timeofday = TimeOfDay(
                                  hour: time.hour, minute: time.minute);
                              _time = DateFormat("HH:mm").format(time);
                              setState(() {});
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  ),
                  //time picker
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[Icon(Icons.add), Text("Create")],
                          ),
                          onPressed: onAdd,
                        ),
                        RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.cancel),
                              Text("Cancel")
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
