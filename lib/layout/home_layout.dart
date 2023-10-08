import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/shared/cubit/cubit.dart';
import 'package:todo_application/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titlController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..creatDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition:state is! AppGetDatabaseLoadingState ,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit
                          .insertToDatabase(
                              title: titlController.text,
                              time: dateController.text,
                              date: timeController.text);
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
                                                lastDate: DateTime.parse(
                                                    '2023-11-04'))
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
                          cubit.changBottomSheetState(
                              isShow: false, icon: Icons.edit);
                        });
                    cubit.changBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
                child: Icon(cubit.fabIcon)),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline_outlined),
                      label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: 'Archived'),
                ]),
          );
        },
      ),
    );
  }
}
