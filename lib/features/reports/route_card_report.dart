import 'dart:io';
import 'package:flutter/services.dart';
import 'package:kovaii_fine_coat/constant/images.dart';
import 'package:kovaii_fine_coat/csv/csv_loader.dart';
import 'package:kovaii_fine_coat/features/report_components/report_components.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class RouteCardPdf {
  /// Generate and save Route Card PDF
  static Future<void> savePdf({
    required String routeCardNo,
    required String date,
    required String partName,
    required String drawingNo,
    required String drawingRevNo,
    required String poNo,
    required String poDate,
    required List<Map<String, String>> operations,
  }) async {
    final pdf = pw.Document();

    final csvData = await loadCsvFile("assets/csv/formatNo.csv");

    // Find ROUTE CARD entry
    final routeCardRow = csvData.firstWhere(
      (row) => row["FORMAT NAME"] == "ROUTE CARD",
      orElse: () => {},
    );

    final formatNo = routeCardRow["FORMAT NO"] ?? "";
    final revisionNo = routeCardRow["REVISION NO"] ?? "";

    Uint8List? logoImage;
    try {
      logoImage = (await rootBundle.load(AppImages.logo)).buffer.asUint8List();
    } catch (e) {
      print('Logo not found: $e');
    }

    pdf.addPage(
      pw.MultiPage(
        maxPages: 50,
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(8),
        header: (context) => _buildHeader(
          logoImage,
          routeCardNo,
          date,
          partName,
          drawingNo,
          drawingRevNo,
          poNo,
          poDate,
        ),
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

        build: (pw.Context context) {
          return [
            // Main Route Card Table
            _buildRouteCardTable(operations),
            pw.SizedBox(height: 10),
            // Bottom Reference Section
            _buildBottomReferenceSection(),
            pw.SizedBox(height: 10),
          ];
        },
      ),
    );

    // Save PDF to local storage
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/route_card.pdf");
    await file.writeAsBytes(await pdf.save());

    // (Optional) Share or open
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'route_card.pdf',
    );
  }

  // Header Section
  static pw.Widget _buildHeader(
    Uint8List? logoImage,
    String routeCardNo,
    String date,
    String partName,
    String drawingNo,
    String drawingRevNo,
    String poNo,
    String poDate,
  ) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
      child: pw.Column(
        children: [
          // 1st Row - Logo, Company Name, Route Card Info
          pw.Container(
            height: 60,
            child: pw.Row(
              children: [
                // Logo
                pw.Container(
                  width: 100,
                  padding: const pw.EdgeInsets.all(2),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(right: pw.BorderSide(width: 1)),
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
                // Company Name
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(right: pw.BorderSide(width: 1)),
                    ),
                    child: pw.Center(
                      child: labelText(
                        "KOVAII FINE COAT (P) LIMITED",
                        isHeader: true,
                        isBold: true,
                      ),
                    ),
                  ),
                ),
                // Route Card Info
                pw.Expanded(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Row(
                        children: [
                          labelText("ROUTE CARD NO:", isBold: true),
                          labelText(routeCardNo),
                        ],
                      ),

                      rowDivider(),
                      pw.Row(
                        children: [
                          labelText("DATE:", isBold: true),
                          pw.Text(
                            "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 2nd Row - Route Card Title
          pw.Container(
            height: 30,
            decoration: const pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide(width: 1)),
            ),
            child: pw.Center(
              child: labelTextSubHead("ROUTE CARD", isBold: true),
            ),
          ),
          // 3rd Row - Part Details
          pw.Container(
            height: 30,
            decoration: const pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide(width: 1)),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: _headerCell("PART NAME:", fontSize: 9, isBold: true),
                ),
                pw.Container(width: 1, color: PdfColors.black),
                pw.Expanded(flex: 4, child: _headerCell(partName, fontSize: 9)),
                pw.Container(width: 1, color: PdfColors.black),
                pw.Expanded(
                  flex: 3,
                  child: _headerCell("REV NO: 0", fontSize: 9, isBold: true),
                ),
              ],
            ),
          ),
          // 4th Row - Drawing Details
          pw.Container(
            height: 30,
            decoration: const pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide(width: 1)),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: _headerCell("DRAWING NO:", fontSize: 9, isBold: true),
                ),
                pw.Container(width: 1, color: PdfColors.black),
                pw.Expanded(
                  flex: 4,
                  child: _headerCell(drawingNo, fontSize: 9),
                ),
                pw.Container(width: 1, color: PdfColors.black),
                pw.Expanded(
                  flex: 3,
                  child: _headerCell("REV NO:0", fontSize: 9),
                ),
              ],
            ),
          ),
          // 5th Row - PO Details
          pw.Container(
            height: 30,
            decoration: const pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide(width: 1)),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: _headerCell(
                    "P.O NO / DATE:",
                    fontSize: 9,
                    isBold: true,
                  ),
                ),
                pw.Container(width: 1, color: PdfColors.black),
                pw.Expanded(
                  flex: 4,
                  child: _headerCell("${poNo}/ ${poDate}", fontSize: 9),
                ),
                pw.Container(width: 1, color: PdfColors.black),
                pw.Expanded(
                  flex: 3,
                  child: _headerCell(
                    "MIN NO/DATE: ",
                    fontSize: 9,
                    isBold: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for header cells
  static pw.Widget _headerCell(
    String text, {
    double fontSize = 9,
    bool isBold = false,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Main Route Card Table
  static pw.Widget _buildRouteCardTable(List<Map<String, String>> operations) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      columnWidths: {
        0: const pw.FixedColumnWidth(
          150,
        ), // STORES (merged OPN NO + WORK CENTER)
        1: const pw.FixedColumnWidth(
          280,
        ), // PARAMETERS to REJ QTY (150+40+40+40+40)
        2: const pw.FixedColumnWidth(150), // SIGN / DATE
      },
      children: [
        // Table Header
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            // Merged header for OPN NO and WORK CENTER
            pw.Container(
              height: 30,

              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Center(
                      child: labelTextSubHead(
                        "OPN NO",
                        isTableHeader: true,
                        isBold: true,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.5,
                    height: double.infinity,
                    color: PdfColors.black,
                  ),
                  pw.Expanded(
                    child: pw.Center(
                      child: labelTextSubHead(
                        "WORK CENTER",
                        isTableHeader: true,
                        isBold: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Merged header for PARAMETERS to REJ QTY
            pw.Container(
              height: 30,

              child: pw.Row(
                children: [
                  pw.Container(
                    width: 120,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(right: pw.BorderSide(width: 0.5)),
                    ),
                    child: pw.Center(
                      child: labelTextSubHead(
                        "PARAMETERS",
                        isTableHeader: true,
                        isBold: true,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 40,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(right: pw.BorderSide(width: 0.5)),
                    ),
                    child: pw.Center(
                      child: labelTextSubHead(
                        "PLAN\nQTY",
                        isTableHeader: true,
                        isBold: true,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 40,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(right: pw.BorderSide(width: 0.5)),
                    ),
                    child: pw.Center(
                      child: labelTextSubHead(
                        "ACC.\nQTY",
                        isTableHeader: true,
                        isBold: true,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 40,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(right: pw.BorderSide(width: 0.5)),
                    ),
                    child: pw.Center(
                      child: labelTextSubHead(
                        "RW\nQTY",
                        isTableHeader: true,
                        isBold: true,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 40,
                    child: pw.Center(
                      child: labelTextSubHead(
                        "REJ.\nQTY",
                        isTableHeader: true,
                        isBold: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _tableHeaderCell("SIGN / DATE"),
          ],
        ),

        // Stores Row
        pw.TableRow(
          children: [
            // STORES merged across OPN NO and WORK CENTER
            pw.Container(
              height: 70,
              child: pw.Center(
                child: labelTextSubHead(
                  "STORES",
                  isTableHeader: true,
                  isBold: true,
                ),
              ),
            ),
            // PARAMETERS to REJ QTY merged with specifications
            pw.Container(
              height: 70,
              child: pw.Column(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
                      ),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: labelTextSubHead(
                            "SPECIFICATION",
                            isTableHeader: true,
                            isBold: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
                      ),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: labelTextSubHead(
                            "MATERIAL:",
                            isTableHeader: true,
                            isBold: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: labelTextSubHead(
                            "QTY:",
                            isTableHeader: true,
                            isBold: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Container(height: 70), // SIGN / DATE
          ],
        ),

        // Operations Rows (Dynamic from Form)
        ...operations.map(
          (op) => pw.TableRow(
            children: [
              // Split OPN NO and WORK CENTER in operations rows
              pw.Container(
                height: 35,

                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Center(
                        child: pw.Text(
                          op["opNo"] ?? "-",
                          style: const pw.TextStyle(fontSize: 9),
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.5,
                      height: double.infinity,
                      color: PdfColors.black,
                    ),
                    pw.Expanded(
                      child: pw.Center(
                        child: pw.Text(
                          op["wc"] ?? "-",
                          style: const pw.TextStyle(fontSize: 9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Split PARAMETERS to REJ QTY in operations rows
              pw.Container(
                height: 35,

                child: pw.Row(
                  children: [
                    pw.Container(
                      width: 120,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(right: pw.BorderSide(width: 0.5)),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          op["param"] ?? "",
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 40,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(right: pw.BorderSide(width: 0.5)),
                      ),
                      child: pw.Center(
                        child: labelTextSubHead("", isTableHeader: true),
                      ),
                    ),
                    pw.Container(
                      width: 40,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(right: pw.BorderSide(width: 0.5)),
                      ),
                      child: pw.Center(
                        child: labelTextSubHead("", isTableHeader: true),
                      ),
                    ),
                    pw.Container(
                      width: 40,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(right: pw.BorderSide(width: 0.5)),
                      ),
                      child: pw.Center(
                        child: labelTextSubHead("", isTableHeader: true),
                      ),
                    ),
                    pw.Container(
                      width: 40,
                      child: pw.Center(
                        child: labelTextSubHead("", isTableHeader: true),
                      ),
                    ),
                  ],
                ),
              ),
              _tableDataCell(""), // SIGN / DATE
            ],
          ),
        ),
      ],
    );
  }

  // Table header cell
  static pw.Widget _tableHeaderCell(String text, {double fontSize = 9}) {
    return pw.Container(
      height: 30,
      padding: const pw.EdgeInsets.all(3),
      child: pw.Center(
        child: pw.Text(
          text,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: fontSize,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Table data cell
  static pw.Widget _tableDataCell(String text, {double fontSize = 9}) {
    return pw.Container(
      height: 35,
      padding: const pw.EdgeInsets.all(3),
      child: pw.Center(
        child: pw.Text(
          text.isEmpty ? '' : text,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }

  // Bottom Reference Section
  static pw.Widget _buildBottomReferenceSection() {
    return pw.Column(
      children: [
        // Despatch Details and Remarks
        pw.Container(
          height: 60,
          decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
          child: pw.Row(
            children: [
              pw.Container(
                width: 200,

                padding: const pw.EdgeInsets.all(6),
                child: pw.Text(
                  "DESPATCH DETAILS:",
                  style: pw.TextStyle(
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              verticalDivider(),

              pw.Container(
                width: 380,
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text(
                  "REMARKS:",
                  style: pw.TextStyle(
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom Reference Rows
        pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          columnWidths: {
            0: const pw.FixedColumnWidth(200), // Label column
            1: const pw.FixedColumnWidth(380), // Value column
          },
          children: [
            _buildBottomReferenceRow("PLANNED QTY:"),
            _buildBottomReferenceRow("ACCEPTED QTY:"),
            _buildBottomReferenceRow("RW QTY:"),
            _buildBottomReferenceRow("REJ QTY:"),
          ],
        ),
      ],
    );
  }

  // Bottom reference row
  static pw.TableRow _buildBottomReferenceRow(String text) {
    return pw.TableRow(
      children: [
        // First cell (height comes from text or fixed if needed)
        pw.Container(
          height: 35,
          width: 200,
          padding: const pw.EdgeInsets.all(6),
          decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
              text,
              style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ),

        pw.Container(
          width: 380,
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide.none,
              bottom: pw.BorderSide.none,
              right: pw.BorderSide.none,
              top: pw.BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
