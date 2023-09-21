// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';

import '../bmi_result/BMIresult.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isMale = true;
  double height = 120;
  int age = 18;
  double weight = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator "),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isMale ? Colors.blue : Colors.grey),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage("assets/images/male.png"),
                            height: 90,
                            width: 90,
                          ),
                          Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: !isMale ? Colors.blue : Colors.grey),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage("assets/images/female.png"),
                            height: 90,
                            width: 90,
                          ),
                          Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Height",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "${height.round()}",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "CM",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                      value: height,
                      max: 220,
                      min: 80,
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      })
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "WEIGHT",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$weight",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                            heroTag: 'weight ++ ',
                            mini: true,
                            child: const Icon(Icons.add),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                weight--;
                              });
                            },
                            heroTag: 'weight -- ',
                            mini: true,
                            child: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Age",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$age",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                age++;
                              });
                            },
                            heroTag: 'age ++ ',
                            mini: true,
                            child: const Icon(Icons.add),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                age--;
                              });                            
                            },
                            heroTag: 'age ++  ',
                            mini: true,
                            child: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
        Container(
            width: double.infinity,
            color: Colors.blue,
            height: 50.0,
            child: MaterialButton(
                onPressed: () {
                  var Result = weight / pow(height/100, 2);
                  print(Result.round());
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder:(context)=>  BMIResultScreen(
                      age: age,
                      isMale: isMale,
                      weight: weight,
                      height: height,
                      result: Result,
                    )
                  ));
                }, 
                child: const Text("Calculate")))
      ]),
    );
  }
}
