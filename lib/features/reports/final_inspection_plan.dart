import 'package:kovaii_fine_coat/features/components/report_components.dart';
import 'package:kovaii_fine_coat/features/models/final_inspection_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';

class FinalInspectionPlan {
  static pw.Widget generateHeader(Uint8List? logo, FinalInspectionModel model) {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [_buildHeader(logo), _buildTable(model), _buildFooter()],
    );
  }

  static pw.Widget _buildHeader(Uint8List? logo) {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: 60,
                height: 60,
                padding: pw.EdgeInsets.all(5),
                child: logo != null
                    ? pw.Image(pw.MemoryImage(logo), fit: pw.BoxFit.contain)
                    : pw.Center(
                        child: pw.Text(
                          'IQAA',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ),
              ),

              verticalDivider(h: 60),

              // Company Name
              pw.Expanded(
                child: pw.Center(
                  child: pw.Text(
                    "FINE COATS (P) LTD",
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ),
              ),

              // Title
            ],
          ),

          rowDivider(),

          pw.Container(
            padding: pw.EdgeInsets.all(10),
            alignment: pw.Alignment.center,
            child: pw.Text(
              "FINAL INSPECTION PLAN",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 10),
            ),
          ),

          rowDivider(),

          // 2nd Row: Details Table
          pw.Row(
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      labelText("PART NAME:"),
                      rowDivider(),
                      labelText("DRAWING NO:"),
                      rowDivider(),
                      labelText("MATERIAL:"),
                      rowDivider(),
                      labelText("ID NO:"),
                      rowDivider(),
                    ],
                  ),
                ),
              ),
              verticalDivider(h: 81),
              pw.Expanded(
                flex: 2,
                child: pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      labelText("CUSTOMER NAME:"),
                      rowDivider(),
                      labelText("P.O NO/DATE"),
                      rowDivider(),
                      labelText("NCR.IF ANY QTY"),
                      rowDivider(),
                      labelText("ACC.QTY:"),
                      rowDivider(),
                    ],
                  ),
                ),
              ),
              verticalDivider(h: 81),
              pw.Expanded(
                child: pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,

                    children: [
                      labelText("FIR NO:"),
                      rowDivider(),
                      labelText("DATE:"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildTable(FinalInspectionModel model) {
    // Define table headers
    final headers = [
      'S.No',
      'Drg Location',
      'Parameters',
      'Drg Specification',
      'Key Char',
      'Evaluation',
      'Inst Id No',
      'Observed Dimensions',
      'Remarks',
    ];

    // Table data from the model
    final data = model.qualityPlanTableData;

    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
      children: [
        // Header Row
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: headers
              .map(
                (header) => pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    header,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 9,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),

        // Data Rows
        ...data.map(
          (row) => pw.TableRow(
            children: row
                .map(
                  (cell) => pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      cell,
                      style: const pw.TextStyle(fontSize: 9),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
      child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [pw.Expanded(child: pw.Container(
              child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start,children: [ labelText("CONCLUTION:"),
              verticalDivider(h: 20),
              labelText("ALL DIMENSIONS ARE INSPECTED AND ACCEPTED"),])
            ))
             
            ],
          ),
          rowDivider(),
          pw.Container(
            
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  labelText("INSPECTED BY:"),
                  verticalDivider(h: 20),
                  labelText("VERIFIED BY"),
                  verticalDivider(h: 20),
                  labelText("APPROVED BY"),
                ],
              ),
            
          ),
          rowDivider(),
          pw.Container(
        
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  labelText("DATE:"),
                  verticalDivider(h: 20),
                  labelText("DATE:"),
                  verticalDivider(h: 20),
                  labelText("DATE:"),
                ],
              ),
            
          ),
        ],
      ),
    );
  }
}
