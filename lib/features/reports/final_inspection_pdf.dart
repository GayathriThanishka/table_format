import 'dart:typed_data';
import 'package:kovaii_fine_coat/features/components/report_components.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFInspectionReportGenerator {
  static Future<Uint8List> generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(15),
        build: (pw.Context context) {
          return [
            _buildPDFContent(),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildPDFContent() {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 0.5),
      ),
      child: pw.Column(
        children: [
          _buildPDFHeader(),
          _buildPDFMainHeaderRow(),
          
          // Data Rows
          _buildPDFDataRow(1, "", "TOTAL LENGTH", "1051.00(+0.00/-0.50)", "Y", "VERNIER CALIPER", "KFC/D/VC/001"),
          _buildPDFDataRow(2, "...............", "SLOT LENGTH", "10.00 ±0.20", "Y", "DIGITAL VERNIER CALIPER", "KFC/D/VC/098"),
          _buildPDFDataRow(3, "...............", "SLOT LENGTH", "25.00 ±0.20", "Y", "DIGITAL VERNIER CALIPER", "KFC/D/VC/098"),
          _buildPDFDataRow(4, "...............", "SLOT REF LENGTH", "53.50 ±0.30", "Y", "DIGITAL VERNIER CALIPER", "KFC/D/VC/098"),
          _buildPDFDataRow(5, "...............", "SLOT WIDTH", "21.50 ±0.20", "Y", "DIGITAL VERNIER CALIPER", "KFC/D/VC/098"),
          _buildPDFDataRow(6, "...............", "SLOT WIDTH", "14.00 ±0.20", "Y", "DIGITAL VERNIER CALIPER", "KFC/D/VC/098"),
          _buildPDFDataRow(7, "...............", "STRAIGHTNESS UPTO 1051MM", "0.50", "Y", "FEELER GAUGE", "..............."),
          _buildPDFDataRow(8, "...............", "TWIST UPTO 1051MM", "0.50", "Y", "FEELER GAUGE", "..............."),
          _buildPDFDataRow(9, "...............", "SURFACE FINISH", "NO SCRATCH & LINE MARK", "Y", "VISUAL", "..............."),
          _buildPDFDataRow(10, "...............", "SURFACE TREATMENT WHITE ANODIZE THICKNESS", "20 - 25 MICRON", "Y", "DIGITAL THICKNESS GAUGE", "KFC/D/THK/045"),
          _buildPDFDataRow(11, "...............", "ANODIZING COLOR", "BRIGHT NATURAL", "Y", "VISUAL", "..............."),
          _buildPDFDataRow(12, "...............", "STRAIGHTNESS ERROR IN CONCAVE SHAPE", "0.00 TO 0.50", "Y", "FEELER GAUGE", "..............."),
          _buildPDFDataRow(13, "...............", "APPEARANCE", "NO BURR, DENT & DAMAGES", "Y", "VISUAL", "..............."),
          
          // Empty rows
          _buildPDFEmptyRow(14),
          _buildPDFEmptyRow(15),
          
          // Conclusion Row
          _buildPDFConclusionRow(),
          
          // Footer Rows
          _buildPDFFooterRow(),
        ],
      ),
    );
  }

  static pw.Widget _buildPDFHeader() {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            height: 50,
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  width: 100,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 1),
                  ),
                  alignment: pw.Alignment.center,
                  child: labelText(
                    "kfc",
                    
                  ),
                ),
                pw.Container(width: 1, height: 60, color: PdfColors.black),
                pw.Expanded(
                  child: pw.Center(
                    child: labelText(
                      "KOVAII FINE COAT (P) LIMITED",isBold: true,isHeader: true
                      
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(height: 1, color: PdfColors.black),
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            alignment: pw.Alignment.center,
            child: labelText(
              "FINAL INSPECTION PLAN CUM REPORT",isBold: true,isHeader: true
             
            ),
          ),
          pw.Container(height: 1, color: PdfColors.black),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    labelText("PART NAME:",isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("DRAWING NO:",isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("MATERIAL:",isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("ID NO:",isBold: true),
                  ],
                ),
              ),
              pw.Container(width: 1, height: 120, color: PdfColors.black),
              pw.Expanded(
                flex: 2,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    labelText("CUSTOMER NAME:",isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("P.O NO/DATE",isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("NCR.IF ANY QTY",isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("ACC.QTY:",isBold: true),
                  ],
                ),
              ),
              pw.Container(width: 1, height: 120, color: PdfColors.black),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    labelText("FIR NO:",isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("DATE:",isBold: true),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  static pw.Widget _buildPDFMainHeaderRow() {
    return pw.Container(
      height: 50,
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black, width: 0.5)),
      ),
      child: pw.Row(
        children: [
          _buildPDFHeaderCell("SL\nNO", 30),
          _buildPDFHeaderCell("ORG.\nLOCATION", 53),
          _buildPDFHeaderCell("PARAMETERS", 100),
          _buildPDFHeaderCell("ORG. SPECIFICATION", 100),
          _buildPDFHeaderCell("KEY\nCHAR", 40),
          _buildPDFHeaderCell("EVALUATION", 100),
          _buildPDFHeaderCell("INST ID NO", 80),
          _buildPDFHeaderCell("OBSERVED DIMENSIONS", 250),
          _buildPDFHeaderCell("REMARKS", 60),
        ],
      ),
    );
  }

  static pw.Widget _buildPDFDataRow(
    int slNo,
    String orgLocation,
    String parameters,
    String specification,
    String keyChar,
    String evaluation,
    String instIdNo,
  ) {
    return pw.Container(
      height: 35,
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black, width: 0.5)),
      ),
      child: pw.Row(
        children: [
          _buildPDFDataCell(slNo.toString(), 30),
          _buildPDFDataCell(orgLocation, 53),
          _buildPDFDataCell(parameters, 100),
          _buildPDFDataCell(specification, 100),
          _buildPDFDataCell(keyChar, 40),
          _buildPDFDataCell(evaluation, 100),
          _buildPDFDataCell(instIdNo, 80),
          _buildPDFObservedDimensionsGrid(),
          _buildPDFDataCell("", 60),
        ],
      ),
    );
  }

  static pw.Widget _buildPDFEmptyRow(int slNo) {
    return pw.Container(
      height: 35,
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black, width: 0.5)),
      ),
      child: pw.Row(
        children: [
          _buildPDFDataCell(slNo.toString(), 30),
          _buildPDFDataCell("...............", 53),
          _buildPDFDataCell("", 100),
          _buildPDFDataCell("", 100),
          _buildPDFDataCell("", 40),
          _buildPDFDataCell("", 100),
          _buildPDFDataCell("", 80),
          _buildPDFObservedDimensionsGrid(),
          _buildPDFDataCell("", 60),
        ],
      ),
    );
  }

  static pw.Widget _buildPDFObservedDimensionsGrid() {
    return pw.Container(
      width: 250,
      child: pw.Row(
        children: List.generate(
          10,
          (index) => pw.Expanded(
            child: pw.Container(
              height: double.infinity,
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  right: pw.BorderSide(
                    color: PdfColors.black,
                    width: index < 9 ? 0.5 : 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static pw.Widget _buildPDFConclusionRow() {
    return pw.Container(
      height: 40,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: PdfColors.black, width: 0.5),
          bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
        ),
      ),
      child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(child: pw.Container(
      
            alignment: pw.Alignment.centerLeft,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(color: PdfColors.black, width: 0.5),
              ),
            ),
            child: labelText(
              "CONCLUSION :",isBold: true
              
            ),
          ), ),
          pw.Expanded(child: pw.Container(
           
           alignment: pw.Alignment.centerLeft,
            child: labelText(
              "ALL DIMENSIONS ARE INSPECTED AND ACCEPTED",isBold: true,
              
            ),
          ), )
         
         
        ],
      ),
    );
  }

  static pw.Widget _buildPDFFooterRow() {
    return pw.Container(
      height: 80,
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Column(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                     // padding: const pw.EdgeInsets.all(8),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
                        ),
                      ),
                      child: labelText(
                        "INSPECTED BY :",isBold: true
                        
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                     // padding: const pw.EdgeInsets.all(8),
                      child: labelText(
                        "DATE        :",isBold: true
                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Column(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                     // padding: const pw.EdgeInsets.all(8),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
                        ),
                      ),
                      child: labelText(
                        "VERIFIED BY :",isBold: true
                        
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                     // padding: const pw.EdgeInsets.all(8),
                      child: labelText(
                        "DATE        :",
                        isBold: true
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Column(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                     // padding: const pw.EdgeInsets.all(8),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
                        ),
                      ),
                      child: labelText(
                        "APPROVED BY :",
                        isBold: true
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                    //  padding: const pw.EdgeInsets.all(8),
                      child: labelText(
                        "DATE        :"
                        ,isBold: true
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPDFHeaderCell(String text, double width) {
    return pw.Container(
      width: width,
      height: double.infinity,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 0.5),
      ),
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        textAlign: pw.TextAlign.center,
        maxLines: 2,
      ),
    );
  }

  static pw.Widget _buildPDFDataCell(String text, double width) {
    return pw.Container(
      width: width,
      height: double.infinity,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 0.5),
      ),
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.all(2),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 9),
        textAlign: pw.TextAlign.center,
        maxLines: 2,
        overflow: pw.TextOverflow.clip,
      ),
    );
  }

  // Method to generate and save/share PDF
  static Future<void> generateAndShowPDF() async {
    final pdfBytes = await generatePDF();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
      name: 'Final_Inspection_Report.pdf',
    );
  }

  // Method to save PDF to device
  static Future<void> savePDF() async {
    final pdfBytes = await generatePDF();
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'Final_Inspection_Report.pdf',
    );
  }
}