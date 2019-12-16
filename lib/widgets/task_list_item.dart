import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerarray/providers/todos_model.dart';
import 'package:providerarray/models/task.dart';
import 'package:date_format/date_format.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final timeNow = DateTime.now().millisecondsSinceEpoch;
  TaskListItem({@required this.task});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Switch(
        value: task.completed==0?false:true,
        onChanged: (bool checked) =>
            {Provider.of<TodosModel>(context, listen: false).toggleTodo(task)},
        activeTrackColor: Colors.lightGreenAccent,
        activeColor: Colors.green,
      ),
      title: Text(task.title,
      style: TextStyle(color: timeNow>task.date && task.date!=0?Colors.red:Colors.black)),
      subtitle: Text(
        task.date==0?'No Date':DateTime.fromMillisecondsSinceEpoch(
                                task.date).toString().substring(0,16),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          Provider.of<TodosModel>(context, listen: false).deleteTodo(task);
        },
      ),
    );
  }
}
