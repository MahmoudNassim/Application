import 'package:flutter/material.dart';

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
        var suffix ,
        var obsecuretext= false ,
        var suffixpressed,
        var onTap ,
        var isClickable = true 
        }) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      obscureText: obsecuretext,
      onFieldSubmitted: onSumbit,
      onChanged: onChanged,
      validator: validate,
      onTap: onTap ,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffix: suffix!= null ? IconButton(onPressed:suffixpressed , icon: Icon(suffix)) : null,
        border: const OutlineInputBorder(),
      ),
    );
    Widget buildTaskItem(Map model)=>  Padding(
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${model['title']}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              ),
              Text("${model['date']}",
              style: TextStyle(
                color: Colors.grey
              ),
              ),
    
            ],
          ),
        ],
      ),
    );
  
