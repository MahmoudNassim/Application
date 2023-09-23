import 'package:flutter/material.dart';
import 'package:todo_application/shared/components/components.dart';
import 'package:todo_application/shared/components/constants.dart';

class NewTasksScreen extends StatefulWidget {

  NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(itemBuilder: (context,index)=>buildTaskItem(tasks[index]), separatorBuilder: (context,index)=>Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    ), itemCount: tasks.length);
  }
}