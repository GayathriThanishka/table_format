import 'package:flutter/material.dart';

import 'package:kovaii_fine_coat/features/ui/final_inspection_ui.dart';
import 'package:kovaii_fine_coat/features/ui/raw_material_report.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: 
      //RawMaterialInspection()
      InspectionReportPage()
    );
  }
}
