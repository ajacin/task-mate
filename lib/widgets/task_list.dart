import 'package:flutter/material.dart';
import 'package:providerarray/providers/todos_model.dart';
import 'package:providerarray/widgets/task_list_item.dart';
import 'package:providerarray/models/task.dart';

class TaskList extends StatelessWidget{
  final List<Task> tasks;
  TaskList({@required this.tasks});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTasks()
    );
  }

  List<Widget> getChildrenTasks(){
    return tasks.map((todo) => TaskListItem(task: todo)).toList();
  }
}
