import 'package:flutter/material.dart';
import 'package:kovaii_fine_coat/features/HOME/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home()
    );
  }
}
