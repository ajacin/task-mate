import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerarray/models/taskdetails.dart';
import 'package:providerarray/providers/task_model.dart';

import 'package:providerarray/providers/todos_model.dart';
import 'package:providerarray/models/task.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final List tasks = [
    {"title":"Buy computer science book from Agarwal book store", "completed": true},
    {"title":"Send updated logo and source files", "completed": false},
    {"title":"Recharge broadband bill", "completed": false},
    {"title":"Pay telephone bill", "completed": false},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Provider.of<TaskModel>(context, listen: false).fetchTask(widget.id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskState = Provider.of<TaskModel>(context).task;
    return 
      Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(taskState.title),
            SizedBox(height: 40.0),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20.0),
              child: OverflowBox(
                maxWidth: 500,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text("Today", style: TextStyle(
                      color: Colors.black,
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(width: 100),
                    Text("Tomorrow", style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            ...tasks.map((task)=>Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ListTile(
                title: Text(task["title"], style: TextStyle(
                  decoration: task["completed"] ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationColor: Colors.red,
                  fontSize: 22.0,
                  color: Colors.black
                ),)
            ))),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              IconButton(
                color: Colors.grey.shade700,
                icon: Icon(Icons.menu, size: 30,), onPressed: (){},),
              Spacer(),
              IconButton(
                color: Colors.grey.shade700,
                icon: Icon(FontAwesomeIcons.calendarAlt,size: 30,), onPressed: (){},),
              SizedBox(width: 20.0),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: color2,
        child: Icon(Icons.add),
        onPressed: (){},
      ),
    );
    
  }
  Container _buildHeader(title) {
    return Container(
            height: 150,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  left: -100,
                  top: -150,
                  child: Container(
                    width: 450,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      gradient: LinearGradient(
                        colors: [color1, color2]
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color2,
                          offset: Offset(4.0,4.0),
                          blurRadius: 10.0
                        )
                      ]
                    ),
                  ),
                ),
                
                Container(
                  margin: const EdgeInsets.only(
                    top: 60,
                    left: 30
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title, style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                      ),),
                      SizedBox(height: 10.0),
                      // Text("You have 2 remaining\ntasks for today!", style: TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 18.0
                      // ),)
                    ],
                  ),
                )
              ],
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