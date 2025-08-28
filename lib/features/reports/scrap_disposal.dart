import 'dart:io';

import 'package:flutter/services.dart';
import 'package:kovaii_fine_coat/constant/images.dart';
import 'package:kovaii_fine_coat/csv/csv_loader.dart';
import 'package:kovaii_fine_coat/features/report_components/report_components.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class ScrapDisposalFormPDF {
  static Future<void> savePDF({
    required String partName,
    required String routeCardNo,
    required String partNumber,
     Uint8List? logoImage,
  }) async {
    final pdf = pw.Document();
    final logoImage = (await rootBundle.load(AppImages.logo)).buffer.asUint8List();
       final csvData = await loadCsvFile("assets/csv/formatNo.csv");

// Find ROUTE CARD entry
final routeCardRow = csvData.firstWhere(
  (row) => row["FORMAT NAME"] == "SCRAP DISPOSAL FORM",
  orElse: () => {},
);

final formatNo = routeCardRow["FORMAT NO"] ?? "";
final revisionNo = routeCardRow["REVISION NO"] ?? "";
  
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(16),
        build: (pw.Context context) =>[

          pw.Column(
            children: [
            
              pw.Row(
                children: [
                  pw.Container(
                 
                    height: 60,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child:  pw.Container(
                  width: 100,
                  padding: const pw.EdgeInsets.all(2),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(right: pw.BorderSide(width: 0.5)),
                  ),
                  child: logoImage != null
                      ? pw.Image(
                          pw.MemoryImage(logoImage),
                          fit: pw.BoxFit.contain,
                        )
                      : pw.Center(
                          child: pw.Text(
                            'LOGO',
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      height: 60,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black,width: 0.5),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          'KOVAI FINE COAT (P) LIMITED',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// Subheader: Form Title
              pw.Container(
                height: 40,
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black,width: 0.5),
                ),
                child: pw.Center(
                  child: pw.Text(
                    'SCRAP DISPOSAL FORM',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),

              /// Table using Row structure (7 rows × 4 columns)

              // Row 1
              pw.Row(
                children: [
                  _buildTableCell(label: 'SDF NO.', width: 140),
                  _buildExpandedEmptyCell(label: "", flex: 3),
                  _buildExpandedTextCell(label: 'DATE', flex: 2),
                  _buildExpandedEmptyCell(flex: 2),
                ],
              ),

              // Row 2
              pw.Row(
                children: [
                  _buildTableCell(label: 'NCR NO.', width: 140),
                  _buildExpandedEmptyCell(flex: 3),
                  _buildExpandedTextCell(label: 'DATE', flex: 2),
                  _buildExpandedEmptyCell(flex: 2),
                ],
              ),

              // Row 3
              pw.Row(
                children: [
                  _buildTableCell(label: 'OPERATOR NAME', width: 140),
                  _buildExpandedEmptyCell(flex: 3),
                  
                ],
              ),

              // Row 4
              pw.Row(
                children: [
                  _buildTableCell(label: 'PART NAME', width: 140),
                  _buildExpandedEmptyCell(label: partName, flex: 3),
                
                ],
              ),

              // Row 5
              pw.Row(
                children: [
                  _buildTableCell(label: 'DRAWING NO.', width: 140),
                  _buildExpandedEmptyCell(label: partNumber, flex: 3),
                  _buildExpandedTextCell(label: 'REV:', flex: 2),
                  _buildExpandedEmptyCell(flex: 2),
                ],
              ),

              // Row 6
              pw.Row(
                children: [
                  _buildTableCell(label: 'ROUTE CARD NO.', width: 140),
                  _buildExpandedEmptyCell(label: routeCardNo, flex: 3),
              
                ],
              ),

              // Row 7
              pw.Row(
                children: [
                  _buildTableCell(label: 'REJECTION QTY.', width: 140),
                  _buildExpandedEmptyCell(flex: 3),
                  _buildExpandedTextCell(label: 'COST', flex: 2),
                  _buildExpandedEmptyCell(flex: 2),
                ],
              ),

              /// REASON FOR NCR Section
              pw.Container(
                height: 150,
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black,width: 0.5),
                ),
                child: pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'REASON FOR NCR',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              /// Bottom signature section
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  _buildExpandedTableCell(label: "QA/QC SIGN"),
                  _buildExpandedTableCell(label: "AUTHORISATION"),
                ],
              ),
            ],
          )

        ],

         footer:  (context) => pw.Row(
  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  children: [
    // Left corner (Format info from CSV)
    pw.Container(
      alignment: pw.Alignment.centerLeft,
      margin: const pw.EdgeInsets.only(left: 10),
      child: labelText(
        "Format No: $formatNo _$revisionNo ",
        
      ),
    ),

    // Right corner (Page X of Y)
    pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(right: 10),
      child: labelText(
        "Page ${context.pageNumber} of ${context.pagesCount}",
        
      ),
    ),
  ],
),
        
           
        
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/scrap_disposal.pdf");
    await file.writeAsBytes(await pdf.save());

    // (Optional) Share or open
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'scrap_disposal.pdf',
    );
  }

  /// Helper method for fixed width text cells (Column 1)
  static pw.Widget _buildTableCell({
    required String label,
    required double width,
  }) {
    return pw.Container(
      height: 50,
      width: width,
      padding: const pw.EdgeInsets.symmetric(horizontal: 6),
      alignment: pw.Alignment.centerLeft,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black,width: 0.5),
      ),
      child: pw.Text(
        label,
        style: pw.TextStyle(fontSize: 11, ),
      ),
    );
  }

  /// Helper method for expanded text cells
  static pw.Widget _buildExpandedTextCell({
    required String label,
    required int flex,
  }) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(
        height: 50,
        padding: const pw.EdgeInsets.symmetric(horizontal: 6),
        alignment: pw.Alignment.centerLeft,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black,width: 0.5),
        ),
        child: pw.Text(
          label,
          style: pw.TextStyle(fontSize: 11),
        ),
      ),
    );
  }

  /// Helper method for expanded empty cells
  static pw.Widget _buildExpandedEmptyCell({String? label, required int flex}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(padding: pw.EdgeInsets.only(left: 5),
        height: 50,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black,width: 0.5),
        ),
        child: (label == null || label.isEmpty)
          ? pw.SizedBox() 
          :pw.Align(child: pw.Text(
              label,
              style: pw.TextStyle(fontSize: 11),
            ), alignment: pw.Alignment.centerLeft, )
          
           
      ),
    );
  }

  /// Helper method for expanded table cells with text
  static pw.Widget _buildExpandedTableCell({required String label}) {
    return pw.Expanded(
      child: pw.Container(
        height: 100,
        padding: const pw.EdgeInsets.symmetric(horizontal: 6),
        alignment: pw.Alignment.centerLeft,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black,width: 0.5),
        ),
        child: pw.Align(
          alignment: pw.Alignment.bottomCenter,
          child: pw.Text(
            label,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
