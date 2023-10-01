import 'package:flutter/material.dart';
import 'package:todo_application/layout/home_layout.dart';
import 'package:todo_application/modules/home/Home.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }  
}
