import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButton: const Icon(Icons.add),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
        BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_outlined), label: 'Done'),
        BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
      ]),
    );
  }
}
