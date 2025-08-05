import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

class ReworkNotePDF {
  static Future<Uint8List> generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(16),
        build: (pw.Context context) {
          return pw.Column(
            children: [
              /// Header: Logo + Company Name
              pw.Row(
                children: [
                  pw.Container(
                    width: 140,
                    height: 60,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Center(
                      child: pw.Text(
                        'KFC',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      height: 60,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          'KOVAII FINE COAT (P) LIMITED',
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
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Center(
                  child: pw.Text(
                    'REWORK NOTE',
                    style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),

              /// Table using Row structure (7 rows × 4 columns)

              // Row 1
              pw.Row(
                children: [
                  _buildTableCell(label: 'REWORK NOTE NO:', width: 140),
                  _buildExpandedEmptyCell(flex: 3),
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
                  _buildTableCell(label: 'PART NAME', width: 140),
                  _buildExpandedEmptyCell(flex: 3),
                ],
              ),

              // Row 4
              pw.Row(
                children: [
                  _buildTableCell(label: 'DRAWING NO:', width: 140),
                  _buildExpandedEmptyCell(flex: 3),
                  _buildExpandedTextCell(label: 'REV', flex: 2),
                  _buildExpandedEmptyCell(flex: 2),
                ],
              ),

              // Row 5
              pw.Row(
                children: [
                  _buildTableCell(label: 'ROUTE CARD NO.', width: 140),
                  _buildExpandedEmptyCell(flex: 3),
                ],
              ),

              // Row 7
              pw.Row(
                children: [
                  _buildTableCell(label: 'REWORK QTY.', width: 140),
                  _buildExpandedEmptyCell(flex: 3),
                  _buildExpandedTextCell(label: 'ID NO', flex: 2),
                  _buildExpandedEmptyCell(flex: 2),
                ],
              ),

              /// REASON FOR NCR Section
              pw.Container(
                height: 150,
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'REWORK DETAILS:',
                      style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ),
              ),

              /// Bottom signature section
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  _buildExpandedTableCell(label: "INSPECTION NAME / SIGN"),
                  _buildExpandedTableCell(label: "SHIFT INCHARGE NAME"),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  /// Helper method for fixed width text cells (Column 1)
  static pw.Widget _buildTableCell({required String label, required double width}) {
    return pw.Container(
      height: 50,
      width: width,
      padding: const pw.EdgeInsets.symmetric(horizontal: 6),
      alignment: pw.Alignment.centerLeft,
      decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
      child: pw.Text(
        label,
        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  /// Helper method for expanded text cells
  static pw.Widget _buildExpandedTextCell({required String label, required int flex}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(
        height: 50,
        padding: const pw.EdgeInsets.symmetric(horizontal: 6),
        alignment: pw.Alignment.centerLeft,
        decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
        child: pw.Text(
          label,
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
      ),
    );
  }

  /// Helper method for expanded empty cells
  static pw.Widget _buildExpandedEmptyCell({required int flex}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(
        height: 50,
        decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
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
        decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
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

  // Method to save or share PDF
  static Future<void> savePDF() async {
    final pdfData = await generatePDF();
    await Printing.sharePdf(
      bytes: pdfData,
      filename: 'rework_note.pdf',
    );
  }

  // Method to preview PDF
  static Future<void> previewPDF() async {
    final pdfData = await generatePDF();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfData,
    );
  }
}