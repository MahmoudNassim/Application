import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/layout/home_layout.dart';
import 'package:todo_application/shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomeLayout(),
      debugShowCheckedModeBanner: false,
    );
  }  
}
