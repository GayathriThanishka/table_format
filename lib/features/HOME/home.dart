import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:kovaii_fine_coat/features/reports/final_inspection_plan.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('PDF Preview')),
        body: PdfPreview(
          build: (format) => _generatePdf(),
        ),
      ),
    );
  }

  static Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();

    // Use your FinalInspectionPlan's method
    final header = FinalInspectionPlan.generateHeader(null); // Pass logo if available

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              header,
              // Add more pw.Widgets here if needed
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
