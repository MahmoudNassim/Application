import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class BMIResultScreen extends StatelessWidget {
  final bool isMale ;
  final double height;
  final int age ;
  final double weight ;
  final double result ;
  const BMIResultScreen({super.key, 
   required this.age , 
   required this.height , 
   required this.isMale , 
   required this.weight,
   required this.result
   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(
              "Gender : ${isMale ? 'Male':'Female'}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Age : $age",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Height : ${height.round()}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Weight : ${weight.round()}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Result : ${result.round()}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
