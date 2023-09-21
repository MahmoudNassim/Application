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
            style: TextStyle(color: Colors.white),
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
        var suffixpressed
        }) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      obscureText: obsecuretext,
      onFieldSubmitted: onSumbit,
      onChanged: onChanged,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffix: suffix!= null ? IconButton(onPressed:suffixpressed , icon: Icon(suffix)) : null,
        border: OutlineInputBorder(),
      ),
    );
