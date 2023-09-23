import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/modules/archived_tasks/new_tasks_screen%20copy.dart';
import 'package:todo_application/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_application/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_application/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/shared/components/constants.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titlController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> title = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  Database? database;

  @override
  void initState() {
    super.initState();
    creatDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(title[currentIndex]),
      ),
      body: ConditionalBuilder(
        condition: tasks.length > 0,
        builder: (context) => screens[currentIndex],
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isBottomSheetShown) {
              if (formKey.currentState!.validate()) {
                insertToDatabase(
                        title: titlController.text,
                        time: dateController.text,
                        date: timeController.text)
                    .then((value) {
                  getDataFromDatabase(database).then((value) {
                    Navigator.pop(context);
                    setState(() {
                      isBottomSheetShown = false;
                      fabIcon = Icons.edit;
                      tasks = value;
                    });
                    print(tasks);
                  });
                });
              }
            } else {
              scaffoldKey.currentState!
                  .showBottomSheet((context) {
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                                type: TextInputType.text,
                                controller: titlController,
                                label: 'Task title',
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Title muts not be empty';
                                  }
                                  return null;
                                },
                                prefix: Icons.title),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                                type: TextInputType.text,
                                controller: timeController,
                                label: 'Task Time',
                                onTap: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Time muts not be empty';
                                  }
                                  return null;
                                },
                                prefix: Icons.watch_later_outlined),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                                type: TextInputType.text,
                                controller: dateController,
                                label: 'Task date',
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('2023-11-04'))
                                      .then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'date muts not be empty';
                                  }
                                  return null;
                                },
                                prefix: Icons.calendar_today),
                          ],
                        ),
                      ),
                    );
                  }, elevation: 20.0)
                  .closed
                  .then((value) {
                    isBottomSheetShown = false;
                    setState(() {
                      fabIcon = Icons.edit;
                    });
                  });
              isBottomSheetShown = true;
              setState(() {
                fabIcon = Icons.add;
              });
            }
          },
          child: Icon(fabIcon)),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline_outlined), label: 'Done'),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive), label: 'Archived'),
          ]),
    );
  }

  void creatDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // id
        // title int
        // date String
        // time String
        // status String
        print("Database created");
        database
            .execute(
                'CREATE TABLE tasks (Id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT ,status TEXT)')
            .then((value) {
          print('table Created');
        }).catchError((e) {
          print("Error When Creating Table ${e.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          setState(() {
            tasks = value;
          });
          print(tasks);
        });
        print("Database opend");
      },
    );
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    if (database != null) {
      return await database!.transaction((txn) {
        return txn
            .rawInsert(
                'INSERT INTO tasks (title, date, time, status) VALUES ("$title", "$time", "$date", "new")')
            .then((value) {
          print("$value inserted Successfully");
        }).catchError((e) {
          print("Error When inserting New Task ${e.toString()}");
        });
      });
    } else {
      print("Error: Database is null");
    }
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database!.rawQuery(" SELECT * FROM tasks");
  }
}
