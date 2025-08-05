// import 'package:flutter/material.dart';
// import 'package:kovaii_fine_coat/features/models/final_inspection_model.dart';
// import 'package:kovaii_fine_coat/features/models/header_model.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'dart:typed_data';
// import 'package:kovaii_fine_coat/features/reports/final_inspection_plan.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('PDF Preview')),
//         body: PdfPreview(
//           allowPrinting: false,
//           allowSharing: false,
//           canDebug: false,
//           canChangeOrientation: false,
//           canChangePageFormat: false,
//           build: (format) => _generatePdf(),
//         ),
//       ),
//     );
//   }

//   static Future<Uint8List> _generatePdf() async {
//     final pdf = pw.Document();
//     final headerInfo = HeaderInfoModel(
//       partName: "Sample Part",
//       material: "Steel",
//       idNo: "ID-001",
//       customerName: "ABC Industries",
//       accQty: "100",
//       firNo: "FIR-01",
//       date: "01-08-2025",
//       drawingNumber: 'DRG-123',
//       poDate: 'PO-456 / 01-08-2025',
//       ncrIfAnyQty: '0',
//     );

   

//     final model = FinalInspectionModel(
//       headerInfo: headerInfo,
//       finalInspection: inspectionData,
//     );

//     final headerWithTable = FinalInspectionPlan.generateHeader(null, model);

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(children: [headerWithTable]);
//         },
//       ),
//     );

//     return pdf.save();
//   }
// }
