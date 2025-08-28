import 'package:flutter/material.dart';
import 'package:kovaii_fine_coat/features/reports/route_card_report.dart';
import 'package:kovaii_fine_coat/features/screen/home.dart';





void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: 
      HomeScreen()
    );
  }
}
