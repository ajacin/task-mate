import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerarray/providers/todos_model.dart';
import 'package:providerarray/models/task.dart';
import 'package:date_format/date_format.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class TaskListItem extends StatelessWidget {
  final Task task;
  final timeNow = DateTime.now().millisecondsSinceEpoch;

Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Task?'),
        // content: Text(
        //     'This will delete your task'),
        actions: <Widget>[
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.delete),
                Text('DELETE'),
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
  TaskListItem({@required this.task});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      color: timeNow>task.date && task.date!=0?(task.completed==0?Colors.red[50]:Colors.green[50]):(task.completed==0?Colors.white:Colors.green[50]),
      child: ListTile(
      leading: Switch(
        value: task.completed==0?false:true,
        onChanged: (bool checked) =>
            {Provider.of<TodosModel>(context, listen: false).toggleTodo(task)},
      ),
      title: Text(task.title),
      subtitle: Text(
        task.date==0?'No Date':DateTime.fromMillisecondsSinceEpoch(
                                task.date).toString().substring(0,16),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        // onPressed: () {
        //   Provider.of<TodosModel>(context, listen: false).deleteTodo(task);
        // },
        onPressed: () async {
                final ConfirmAction action = await _asyncConfirmDialog(context);
                if(action == ConfirmAction.ACCEPT){
                  Provider.of<TodosModel>(context, listen: false).deleteTodo(task);
                }
              },
      ),
    ),
    );
  }
}
