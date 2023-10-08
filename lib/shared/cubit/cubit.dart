import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/modules/archived_tasks/archived_tasks_screen%20copy.dart';
import 'package:todo_application/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_application/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_application/shared/components/constants.dart';
import 'package:todo_application/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  List newTasks = [];
  List doneTasks = [];
  List archivedTasks = [];

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  void changIndex(int index) {
    currentIndex = index;
    emit(AppChangBottomNavBarState());
  }

  Database? database;

  void creatDatabase() {
    openDatabase(
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
        getDataFromDatabase(database);
        print("Database opend");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    if (database != null) {
      await database!.transaction((txn) {
        return txn
            .rawInsert(
                'INSERT INTO tasks (title, date, time, status) VALUES ("$title", "$time", "$date", "new")')
            .then((value) {
          print("$value inserted Successfully");
          emit(AppInsertDatabaseState());
          getDataFromDatabase(database);
        }).catchError((e) {
          print("Error When inserting New Task ${e.toString()}");
        });
      });
    } else {
      print("Error: Database is null");
    }
  }

  getDataFromDatabase(database) async {
newTasks = [];
doneTasks = [];
archivedTasks = [];

    emit(AppGetDatabaseLoadingState());
    database!.rawQuery(" SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, '$id']).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }
  
  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE Id = ?', [id])
    .then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangBottomSheetState());
  }
}
