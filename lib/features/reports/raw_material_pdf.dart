import 'dart:io';
import 'package:flutter/services.dart';
import 'package:kovaii_fine_coat/constant/images.dart';
import 'package:kovaii_fine_coat/csv/csv_loader.dart';
import 'package:kovaii_fine_coat/features/report_components/report_components.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class RawMaterialInspectionPDF {
  static Future<void> savePDF({
    required String drawingNo,
    required String poNumber,
    required String poDate,
    required String dcNumber,
    required String dcDate,
    required String minNumber,
    required String customer,
    required String material,
    required String drawingName,
  }) async {
    final pdf = pw.Document();
    final logoImage = (await rootBundle.load(
      AppImages.logo,
    )).buffer.asUint8List();

    // Find ROUTE CARD entry

    final csvData = await loadCsvFile("assets/csv/formatNo.csv");
    final routeCardRow = csvData.firstWhere(
      (row) => row["FORMAT NAME"] == "INWARD INSPECTION REPORT",
      orElse: () => {},
    );

    final formatNo = routeCardRow["FORMAT NO"] ?? "";
    final revisionNo = routeCardRow["REVISION NO"] ?? "";

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(16),
        build: (pw.Context context) {
          return [
            // Main container with border
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeaderSection(logoImage),

                  // Details Section
                  _buildDetailsSection(
                    drawingNo: drawingNo,
                    poNumber: poNumber,
                    poDate: poDate,
                    dcNumber: dcNumber,
                    dcDate: dcDate,
                    minNumber: minNumber,
                    customer: customer,
                    material: material,
                    drawingName: drawingName,
                  ),

                  pw.SizedBox(height: 20),

                  // Dimension Report Section
                  _buildDimensionReportSection(),

                  pw.SizedBox(height: 10),

                  // Footer Section
                  _buildFooterSection(),
                ],
              ),
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
    final file = File("${dir.path}/raw_material.pdf");
    await file.writeAsBytes(await pdf.save());

    // (Optional) Share or open
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'raw_material.pdf',
    );
  }

  static pw.Widget _buildHeaderSection(Uint8List logoImage) {
    return pw.Row(
      children: [
        // KFC Logo Section
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
            child: pw.Image(pw.MemoryImage(logoImage), fit: pw.BoxFit.contain),
          ),
        ),

        // Company Name and Title Section
        pw.Expanded(
          flex: 4,
          child: pw.Container(
            height: 50,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 0.5),
            ),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Center(
                  child: labelText(
                    'KOVAII FINE COAT (P) LIMITED',
                    isHeader: true,
                    isBold: true,
                  ),
                ),
                rowDivider(),
                pw.Center(
                  child: labelText(
                    'RAW MATERIAL INSPECTION REPORT',
                    isBold: true,
                  ),
                ),
              ],
            ),
          ),
        ),

        // SI.NO Section
        pw.Expanded(
          child: pw.Container(
            height: 50,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 0.5),
            ),
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: labelText('SI.NO:', isBold: true),
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDetailsSection({
    required String drawingNo,
    required String drawingName,
    required String poNumber,
    required String poDate,
    required String dcNumber,
    required String dcDate,
    required String minNumber,
    required String customer,
    required String material,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Left Column - Report Details
        pw.Expanded(
          flex: 2,
          child: _buildLeftColumn(
            drawingNo: drawingNo,
            poNumber: poNumber,
            poDate: poDate,
            drawingName: drawingName,
            minNumber: minNumber,
            customer: customer,
            material: material,
          ),
        ),

        pw.SizedBox(width: 60),

        // Middle Column - Additional Details
        pw.Expanded(
          flex: 1,
          child: _buildMiddleColumn(dcNumber: dcNumber, dcDate: dcDate),
        ),

        pw.SizedBox(width: 60),

        // Right Column - Visual Inspection
        pw.SizedBox(width: 250, child: _buildVisualInspectionSection()),

        // Far Right Empty Column
        pw.Expanded(
          flex: 1,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildLeftColumn({
    required String drawingNo,
    required String poNumber,
    required String poDate,
    required String drawingName,

    required String minNumber,
    required String customer,
    required String material,
  }) {
    final data = {
      "REPORT NO": "",
      "MIN NO": minNumber,
      "CUSTOMER/SUPPLIER": customer,
      "P.O NO & DATE": "${poNumber} / ${poDate}",
      "DESCRIPTION": drawingName,
      "DRAWING NO": drawingNo,
      "MATERIAL SPEC": material,
      "APPROVED SOURCE": "YES       NO",
    };

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: data.entries.map((entry) {
        return pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 2),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: 120,
                child: labelText("${entry.key}:", isBold: true),
              ),
              pw.SizedBox(width: 5),
              pw.Expanded(child: labelText(entry.value)),
            ],
          ),
        );
      }).toList(),
    );
  }

  static pw.Widget _buildMiddleColumn({
    required String dcNumber,
    required String dcDate,
  }) {
    final rows = [
      {"label": "DATE", "value": "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",},
      {"label": "", "value": ""},
      {"label": "", "value": ""},
      {"label": "D.C NO:", "value": dcNumber},
      {"label": "DATE:", "value": dcDate},
      {"label": "", "value": ""},
      {"label": "LOT QTY:", "value": ""},
      {"label": "NA", "value": ""},
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: rows
          .map(
            (row) => pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 2),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  labelText(row["label"] ?? "", isBold: true),
                  if ((row["value"] ?? "").isNotEmpty) ...[
                    pw.SizedBox(width: 5),
                    labelText(row["value"] ?? ""),
                  ],
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  static pw.Widget _buildVisualInspectionSection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        labelText("1.VISUAL INSPECTION:", isBold: true),

        // Header Row
        pw.Container(
          height: 30,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 0.5),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [labelText("DENT"), labelText("DAMAGE")],
          ),
        ),

        // YES/NO Options Row 1
        pw.Container(
          height: 30,
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(color: PdfColors.black, width: 0.5),
              bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
              right: pw.BorderSide(color: PdfColors.black, width: 0.5),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              labelText("YES", isBold: true),
              pw.Container(
                width: 0.5,
                height: double.infinity,
                color: PdfColors.black,
              ),
              labelText("NO", isBold: true),
              pw.Container(
                width: 0.5,
                height: double.infinity,
                color: PdfColors.black,
              ),
              labelText("YES", isBold: true),
              pw.Container(
                width: 0.5,
                height: double.infinity,
                color: PdfColors.black,
              ),
              labelText("NO", isBold: true),
            ],
          ),
        ),

        // Empty Row
        pw.Container(
          height: 30,
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(width: 0.5, color: PdfColors.black),
              right: pw.BorderSide(width: 0.5, color: PdfColors.black),
            ),
          ),
        ),

        // BEND/OTHERS Header Row
        pw.Container(
          height: 30,
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(width: 0.5, color: PdfColors.black),
              bottom: pw.BorderSide(width: 0.5, color: PdfColors.black),
              right: pw.BorderSide(width: 0.5, color: PdfColors.black),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              labelText("BEND", isBold: true),
              pw.Container(
                width: 0.5,
                height: double.infinity,
                color: PdfColors.black,
              ),
              labelText("OTHERS", isBold: true),
            ],
          ),
        ),

        // YES/NO Options Row 2
        pw.Container(
          height: 30,
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(width: 0.5, color: PdfColors.black),
              bottom: pw.BorderSide(width: 0.5, color: PdfColors.black),
              right: pw.BorderSide(width: 0.5, color: PdfColors.black),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              labelText("YES", isBold: true),
              pw.Container(
                width: 0.5,
                height: double.infinity,
                color: PdfColors.black,
              ),
              labelText("NO", isBold: true),
              pw.Container(
                width: 0.5,
                height: double.infinity,
                color: PdfColors.black,
              ),
              labelText("YES", isBold: true),
              pw.Container(
                width: 0.5,
                height: double.infinity,
                color: PdfColors.black,
              ),
              labelText("NO", isBold: true),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDimensionReportSection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        labelText("2. DIMENSION REPORT:", isBold: true),
        pw.SizedBox(height: 3),
        pw.Padding(
          padding: const pw.EdgeInsets.only(
            left: 10,
          ), // Adjust the value as needed
          child: _buildDimensionTable(),
        ),
      ],
    );
  }

  static pw.Widget _buildDimensionTable() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Table Header
        pw.Container(
          height: 40,
          width: 700,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 0.5),
          ),
          child: pw.Row(
            children: [
              _buildTableHeaderCell("SL NO", 50),
              _buildTableHeaderCell("DRG.DIMENSION", 230),
              _buildTableHeaderCell("OBSERVED\nDIMENSION", 150),
              _buildTableHeaderCell("EVALUATION", 170),
              _buildTableHeaderCell("REMARK", 100),
            ],
          ),
        ),

        // Table Data Row
        pw.Container(
          height: 90,
          width: 700,
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
              left: pw.BorderSide(color: PdfColors.black, width: 0.5),
              right: pw.BorderSide(color: PdfColors.black, width: 0.5),
            ),
          ),
          child: pw.Row(
            children: [
              _buildTableDataCell("1", 50),
              _buildTableDataCell("", 230),
              _buildTableDataCell("", 150),
              _buildTableDataCell("", 170),
              _buildTableDataCell("", 100),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTableHeaderCell(String text, double width) {
    return pw.Container(
      width: width,
      height: double.infinity,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          right: pw.BorderSide(color: PdfColors.black, width: 0.5),
        ),
      ),
      child: pw.Center(child: labelText(text, isBold: true)),
    );
  }

  static pw.Widget _buildTableDataCell(String text, double width) {
    return pw.Container(
      width: width,
      height: double.infinity,
      padding: const pw.EdgeInsets.all(4),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          right: pw.BorderSide(color: PdfColors.black, width: 0.5),
        ),
      ),
      child: pw.Center(child: labelText(text)),
    );
  }

  static pw.Widget _buildFooterSection() {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(12.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Left Column
          pw.Expanded(
            flex: 1,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                labelText("ACC QTY", isBold: true),
                pw.SizedBox(height: 8),
                labelText("INSPECTED BY", isBold: true),
                pw.SizedBox(height: 8),
                labelText("DATE", isBold: true),
              ],
            ),
          ),

          pw.SizedBox(width: 80),

          // Middle Column
          pw.Expanded(flex: 1, child: labelText("REWORK QTY", isBold: true)),

          pw.SizedBox(width: 100),

          // Right Column
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                labelText("REJ QTY", isBold: true),
                pw.SizedBox(height: 8),
                labelText("APPROVED BY", isBold: true),
                pw.SizedBox(height: 8),
                labelText("DATE", isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
