import 'dart:io';
import 'package:flutter/services.dart';
import 'package:kovaii_fine_coat/constant/images.dart';
import 'package:kovaii_fine_coat/csv/csv_loader.dart';
import 'package:kovaii_fine_coat/features/report_components/report_components.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class StageInspectionReportGenerator {
  static Future<void> savePdf({
    required String drawingNo,
    required String drawingName,
    required String material,
    required String customer,
    required String operationNo,
    required List<Map<String, dynamic>> dataRows, // dynamic rows
  }) async {
    final pdf = pw.Document();

    //load logo image

    final logoImage = (await rootBundle.load(
      AppImages.logo,
    )).buffer.asUint8List();

    // Find format number

    final csvData = await loadCsvFile("assets/csv/formatNo.csv");
    final routeCardRow = csvData.firstWhere(
      (row) => row["FORMAT NAME"] == "FINAL INSPECTION REPORT",
      orElse: () => {},
    );

    final formatNo = routeCardRow["FORMAT NO"] ?? "";
    final revisionNo = routeCardRow["REVISION NO"] ?? "";

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(15),
        build: (pw.Context context) {
          return [
            _buildPDFContent(
              logoImage: logoImage,
              dataRows: dataRows,
              drawingNo: drawingNo,
              drawingName: drawingName,
              material: material,
              customer: customer,
              operationNo: operationNo,
            ),
          ];
        },

        footer: (context) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // Left corner (Format info from CSV)
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              margin: const pw.EdgeInsets.only(left: 10),
              child: labelText("Format No: $formatNo _$revisionNo "),
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
    final file = File("${dir.path}/stage_inspection.pdf");
    final bytes = await pdf.save();
    await file.writeAsBytes(bytes);

    await Printing.sharePdf(bytes: bytes, filename: 'stage_inspection.pdf');
  }

  static pw.Widget _buildPDFContent({
    required List<Map<String, dynamic>> dataRows,
    required Uint8List logoImage,
    required String drawingNo,
    required String drawingName,
    required String material,
    required String customer,
    required String operationNo,
  }) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 0.5),
      ),
      child: pw.Column(
        children: [
          _buildPDFHeader(
            logoImage: logoImage,
            drawingNo: drawingNo,
            drawingName: drawingName,
            material: material,
            customer: customer,
            operationNo: operationNo,
          ),
          _buildPDFMainHeaderRow(),

          // Dynamic rows
          ...dataRows.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final row = entry.value;
            return _buildPDFDataRow(
              index,
              row["orgLocation"] ?? "",
              row["parameters"] ?? "",
              row["specification"] ?? "",
              row["keyChar"] ?? "",
              row["evaluation"] ?? "",
              row["instIdNo"] ?? "",
              (row["observed"] as List<String>? ?? []),
              row["remarks"] ?? "",
            );
          }),

          // Fill with empty rows to maintain table height
          for (int i = dataRows.length + 1; i <= 15; i++) _buildPDFEmptyRow(i),

          _buildPDFConclusionRow(),
          _buildPDFFooterRow(),
        ],
      ),
    );
  }

  // ------------------- Header -------------------
  static pw.Widget _buildPDFHeader({
    required String drawingNo,
    required String drawingName,
    required String material,
    required String customer,
    required String operationNo,
    required Uint8List logoImage,
  }) {
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
                  height: 50,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 0.5),
                  ),
                  child: pw.Container(
                    width: 100,
                    padding: const pw.EdgeInsets.all(2),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(right: pw.BorderSide(width: 0.5)),
                    ),
                    child: pw.Image(
                      pw.MemoryImage(logoImage),
                      fit: pw.BoxFit.contain,
                    ),
                  ),
                ),
                pw.Container(width: 0.1, height: 60, color: PdfColors.black),
                pw.Expanded(
                  child: pw.Center(
                    child: labelText(
                      "KOVAII FINE COAT (P) LIMITED",
                      isBold: true,
                      isHeader: true,
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
              "STAGE INSPECTION PLAN CUM REPORT",
              isBold: true,
              isHeader: true,
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
                    labelText("PART NAME: $drawingName", isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("DRAWING NO: $drawingNo", isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("MATERIAL: $material", isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("OPERATION NO: $operationNo", isBold: true),
                  ],
                ),
              ),
              pw.Container(width: 1, height: 120, color: PdfColors.black),
              pw.Expanded(
                flex: 2,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        labelText("CUSTOMER NAME: ", isBold: true),
                        labelText("$customer"),
                      ],
                    ),

                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("P.O NO/DATE", isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("NCR.IF ANY QTY", isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("ACC.QTY:", isBold: true),
                  ],
                ),
              ),
              pw.Container(width: 1, height: 120, color: PdfColors.black),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    labelText("FIR NO:", isBold: true),
                    pw.Container(height: 1, color: PdfColors.black),
                    labelText("DATE:", isBold: true),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------- Table Header -------------------
  static pw.Widget _buildPDFMainHeaderRow() {
    return pw.Container(
      height: 50,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
        ),
      ),
      child: pw.Row(
        children: [
          _buildPDFHeaderCell("SL\nNO", 30),
          _buildPDFHeaderCell("DRG.\nLOCATION", 53),
          _buildPDFHeaderCell("PARAMETERS", 100),
          _buildPDFHeaderCell("DRG. SPECIFICATION", 100),
          _buildPDFHeaderCell("KEY\nCHAR", 40),
          _buildPDFHeaderCell("EVALUATION", 100),
          _buildPDFHeaderCell("INST ID NO", 80),
          _buildPDFHeaderCell("OBSERVED DIMENSIONS", 250),
          _buildPDFHeaderCell("REMARKS", 60),
        ],
      ),
    );
  }

  // ------------------- Data Row -------------------
  static pw.Widget _buildPDFDataRow(
    int slNo,
    String orgLocation,
    String parameters,
    String specification,
    String keyChar,
    String evaluation,
    String instIdNo,
    List<String> observedValues,
    String remarks,
  ) {
    return pw.Container(
      height: 35,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
        ),
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
          _buildPDFObservedDimensionsGrid(observedValues),
          _buildPDFDataCell(remarks, 60),
        ],
      ),
    );
  }

  // ------------------- Empty Row -------------------
  static pw.Widget _buildPDFEmptyRow(int slNo) {
    return pw.Container(
      height: 35,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
        ),
      ),
      child: pw.Row(
        children: [
          _buildPDFDataCell(slNo.toString(), 30),
          _buildPDFDataCell("", 53),
          _buildPDFDataCell("", 100),
          _buildPDFDataCell("", 100),
          _buildPDFDataCell("", 40),
          _buildPDFDataCell("", 100),
          _buildPDFDataCell("", 80),
          _buildPDFObservedDimensionsGrid([]),
          _buildPDFDataCell("", 60),
        ],
      ),
    );
  }

  // ------------------- Observed Grid -------------------
  static pw.Widget _buildPDFObservedDimensionsGrid(List<String> values) {
    return pw.Container(
      width: 250,
      child: pw.Row(
        children: List.generate(
          10,
          (index) => pw.Expanded(
            child: pw.Container(
              height: double.infinity,
              alignment: pw.Alignment.center,
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  right: pw.BorderSide(
                    color: PdfColors.black,
                    width: index < 9 ? 0.5 : 0.5,
                  ),
                ),
              ),
              child: pw.Text(
                index < values.length ? values[index] : "",
                style: const pw.TextStyle(fontSize: 9),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------- Conclusion -------------------
  static pw.Widget _buildPDFConclusionRow() {
    return pw.Container(
      height: 40,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: PdfColors.black, width: 0.5),
          bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
        ),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.centerLeft,
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  right: pw.BorderSide(color: PdfColors.black, width: 0.5),
                ),
              ),
              child: labelText("CONCLUSION :", isBold: true),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------- Footer -------------------
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
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                            color: PdfColors.black,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: labelText("INSPECTED BY :", isBold: true),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      child: labelText("DATE        :", isBold: true),
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
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                            color: PdfColors.black,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: labelText("VERIFIED BY :", isBold: true),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      child: labelText("DATE        :", isBold: true),
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
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                            color: PdfColors.black,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: labelText("APPROVED BY :", isBold: true),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      child: labelText("DATE        :", isBold: true),
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

  // ------------------- Cell Builders -------------------
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
}
