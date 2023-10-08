import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgound = Colors.blue,
  required String text,
  required var function,
}) =>
    Container(
      width: width,
      color: backgound,
      child: ElevatedButton(
          onPressed: function,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(color: Colors.white),
          )),
    );

Widget defaultFormField(
        {required TextInputType type,
        required TextEditingController controller,
        var onSumbit,
        var onChanged,
        required String label,
        required var validate,
        required var prefix,
        var suffix,
        var obsecuretext = false,
        var suffixpressed,
        var onTap,
        var isClickable = true}) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      obscureText: obsecuretext,
      onFieldSubmitted: onSumbit,
      onChanged: onChanged,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffix: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(),
      ),
    );
Widget buildTaskItem(Map model, context) => Dismissible(
      onDismissed: (direction) {
        
          AppCubit.get(context).deleteData(id: model['Id']);
        
      },
      key: Key(model['id'].toString()),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text("${model['time']}"),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model['title']}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${model['date']}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                color: Colors.green,
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['Id']);
                },
                icon: Icon(Icons.check_box)),
            IconButton(
                color: Colors.black45,
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archive', id: model['Id']);
                },
                icon: Icon(Icons.archive)),
          ],
        ),
      ),
    );
Widget taskBuilder({
  required List tasks
})=>  ConditionalBuilder(
          condition: tasks.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildTaskItem(tasks[index], context),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
              itemCount: tasks.length),
          fallback: (BuildContext context) => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu, color: Colors.grey,size: 100,),
                Text('No Tasks Yet , Please Enter Some Tasks',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
                )
              ],
            ),
          ),
        );
      