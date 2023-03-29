import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "todos",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.pinkAccent,fontSize: 80,fontWeight: FontWeight.w200),
      
    );
  }
}