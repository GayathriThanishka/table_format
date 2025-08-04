import 'package:kovaii_fine_coat/features/components/report_components.dart';
import 'package:kovaii_fine_coat/features/models/final_inspection_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';

class FinalInspectionPlan {
  static pw.Widget generateHeader(
    Uint8List? logo,
    // FinalInspectionModel finalInspectionData,
  ) {
    return _buildHeader(
      logo,
      // finalInspectionData,
    );
  }

  static _buildHeader(Uint8List? logo) {
    return pw.Container(
      margin: pw.EdgeInsets.only(bottom: 10),
      decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
      child: pw.Column(
        children: [
          // 1st Row
          pw.Container(
            height: 30,
            child: pw.Row(
              children: [
                pw.Expanded(flex: 1,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                    child: logo != null
                        ? pw.Image(pw.MemoryImage(logo), fit: pw.BoxFit.contain)
                        : pw.Center(
                            child: pw.Text(
                              'IQAA',
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
                verticalDivider(h: double.maxFinite),
                pw.Expanded(
                  child: pw.Center(
                    child: pw.Text(
                      "FINE COATS (P) LTD",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 2nd Row
          pw.Container(
            height: 40,
            decoration: pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide(width: 1)),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(child:pw.Center(child:labelText("FINAL INSPECTION PLAN") ) ),
              ],
            ),
          ),
        ],
      ),
    );
    // 3rd Row
    //       pw.Container(
    //         height: 40,
    //         decoration: pw.BoxDecoration(
    //           border: pw.Border(top: pw.BorderSide(width: 1)),
    //         ),
    //         child: pw.Row(
    //           children: [
    //             pw.Expanded(child: labelText("Part Name")),
    //             verticalDivider(h: double.maxFinite),
    //             pw.Expanded(
    //               flex: 3,
    //               child: pw.Row(
    //                 children: [
    //                   pw.Expanded(
    //                     child: labelText(details.partName, isBold: true),
    //                   ),
    //                   verticalDivider(h: double.maxFinite),
    //                   pw.Expanded(child: labelText("Part Application")),
    //                   verticalDivider(h: double.maxFinite),
    //                   pw.Expanded(
    //                     child: pw.Center(
    //                       child: labelText("-", textColor: PdfColors.white),
    //                     ),
    //                   ),

    //                   pw.Expanded(
    //                     child: labelText("-", textColor: PdfColors.white),
    //                   ),

    //                   pw.Expanded(
    //                     child: pw.Center(
    //                       child: labelText("-", textColor: PdfColors.white),
    //                     ),
    //                   ),
    //                   verticalDivider(h: double.maxFinite),
    //                   pw.Expanded(child: labelText("Project")),
    //                   verticalDivider(h: double.maxFinite),
    //                   pw.Expanded(child: pw.Center(child: labelText("-"))),
    //                   verticalDivider(h: double.maxFinite),
    //                   pw.Expanded(child: labelText("Location")),
    //                 ],
    //               ),
    //             ),
    //             verticalDivider(h: double.maxFinite),
    //             pw.Expanded(
    //               child: labelText(
    //                 '329/1B1 Sayanmmal Buildings Muppandalyam (post), Alanpalayam',
    //                 isBold: true,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  // Helper method to build form fields

  // Method to generate the complete PDF document
  static Future<Uint8List> generatePDF({
    Uint8List? logo,
    String partName = '',
    String customerName = '',
    String firNo = '',
    String drawingNo = '',
    String poNoDate = '',
    String material = '',
    String ncrQty = '',
    String date = '',
    String idNo = '',
    String accQty = '',
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              generateHeader(logo),
              pw.SizedBox(height: 20),
              // Add more content here as needed for the inspection plan
              pw.Text(
                'Inspection Details:',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              // Add inspection tables, checkboxes, etc. here
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
