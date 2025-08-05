import 'package:flutter/material.dart';
import 'package:kovaii_fine_coat/features/components/report_components.dart';
import 'package:kovaii_fine_coat/features/reports/final_inspection_pdf.dart';
import 'package:kovaii_fine_coat/features/reports/raw_material_pdf.dart';
import 'package:kovaii_fine_coat/features/reports/rework_note.dart';
import 'package:kovaii_fine_coat/features/reports/scrap_disposal.dart';
import 'package:kovaii_fine_coat/features/reports/stage_inspection_pdf.dart';
// Import your PDF generator class
// import 'pdf_inspection_report_generator.dart';

class InspectionReportPage extends StatelessWidget {
  const InspectionReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              // Generate and show PDF preview
              await PDFInspectionReportGenerator.generateAndShowPDF();
            },
            tooltip: 'Print/Preview PDF',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              // Save/Share PDF
              await PDFInspectionReportGenerator.savePDF();

              await StageInspectionReportGenerator.savePDF();

              await RawMaterialInspectionPDF.savePDF();

              await ReworkNotePDF.savePDF();

              await ScrapDisposalFormPDF.savePDF();
            },
            tooltip: 'Save PDF',
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: Column(
                      children: [
                        // Header Row
                        _buildHeader(),
                        _buildMainHeaderRow(),

                        // Data Rows
                        _buildDataRow(
                          1,
                          "",
                          "TOTAL LENGTH",
                          "1051.00(+0.00/-0.50)",
                          "Y",
                          "VERNIER CALIPER",
                          "KFC/D/VC/001",
                        ),
                        _buildDataRow(
                          2,
                          "...............",
                          "SLOT LENGTH",
                          "10.00 ±0.20",
                          "Y",
                          "DIGITAL VERNIER CALIPER",
                          "KFC/D/VC/098",
                        ),
                        _buildDataRow(
                          3,
                          "...............",
                          "SLOT LENGTH",
                          "25.00 ±0.20",
                          "Y",
                          "DIGITAL VERNIER CALIPER",
                          "KFC/D/VC/098",
                        ),
                        _buildDataRow(
                          4,
                          "...............",
                          "SLOT REF LENGTH",
                          "53.50 ±0.30",
                          "Y",
                          "DIGITAL VERNIER CALIPER",
                          "KFC/D/VC/098",
                        ),
                        _buildDataRow(
                          5,
                          "...............",
                          "SLOT WIDTH",
                          "21.50 ±0.20",
                          "Y",
                          "DIGITAL VERNIER CALIPER",
                          "KFC/D/VC/098",
                        ),
                        _buildDataRow(
                          6,
                          "...............",
                          "SLOT WIDTH",
                          "14.00 ±0.20",
                          "Y",
                          "DIGITAL VERNIER CALIPER",
                          "KFC/D/VC/098",
                        ),
                        _buildDataRow(
                          7,
                          "...............",
                          "STRAIGHTNESS UPTO 1051MM",
                          "0.50",
                          "Y",
                          "FEELER GAUGE",
                          "...............",
                        ),
                        _buildDataRow(
                          8,
                          "...............",
                          "TWIST UPTO 1051MM",
                          "0.50",
                          "Y",
                          "FEELER GAUGE",
                          "...............",
                        ),
                        _buildDataRow(
                          9,
                          "...............",
                          "SURFACE FINISH",
                          "NO SCRATCH & LINE MARK",
                          "Y",
                          "VISUAL",
                          "...............",
                        ),
                        _buildDataRow(
                          10,
                          "...............",
                          "SURFACE TREATMENT WHITE ANODIZE THICKNESS",
                          "20 - 25 MICRON",
                          "Y",
                          "DIGITAL THICKNESS GAUGE",
                          "KFC/D/THK/045",
                        ),
                        _buildDataRow(
                          11,
                          "...............",
                          "ANODIZING COLOR",
                          "BRIGHT NATURAL",
                          "Y",
                          "VISUAL",
                          "...............",
                        ),
                        _buildDataRow(
                          12,
                          "...............",
                          "STRAIGHTNESS ERROR IN CONCAVE SHAPE",
                          "0.00 TO 0.50",
                          "Y",
                          "FEELER GAUGE",
                          "...............",
                        ),
                        _buildDataRow(
                          13,
                          "...............",
                          "APPEARANCE",
                          "NO BURR, DENT & DAMAGES",
                          "Y",
                          "VISUAL",
                          "...............",
                        ),

                        // Empty rows
                        _buildEmptyRow(14),
                        _buildEmptyRow(15),

                        // Conclusion Row
                        _buildConclusionRow(),

                        // Footer Rows
                        _buildFooterRow(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "kfc",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                verticalDivider1(h: 60),

                // Company Name
                Expanded(
                  child: Center(
                    child: Text(
                      "FINE COATS (P) LIMITED",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Title
              ],
            ),
          ),

          divider1(),

          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              "FINAL INSPECTION PLAN CUM REPORT",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),

          divider1(),

          // 2nd Row: Details Table
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Expanded(
                flex: 2,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText1("PART NAME:"),
                    divider1(),
                    labelText1("DRAWING NO:"),
                    divider1(),
                    labelText1("MATERIAL:"),
                    divider1(),
                    labelText1("ID NO:"),
                  ],
                ),
              ),

              verticalDivider1(h: 120),
              Expanded(
                flex: 2,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText1("CUSTOMER NAME:"),
                    divider1(),
                    labelText1("P.O NO/DATE"),
                    divider1(),
                    labelText1("NCR.IF ANY QTY"),
                    divider1(),
                    labelText1("ACC.QTY:"),
                  ],
                ),
              ),
              verticalDivider1(h: 120),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    labelText1("FIR NO:"),
                    divider1(),
                    labelText1("DATE:"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainHeaderRow() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Row(
        children: [
          _buildHeaderCell("ID NO\nSL NO", 60),
          _buildHeaderCell("ORG.\nLOCATION", 80),
          _buildHeaderCell("PARAMETERS", 150),
          _buildHeaderCell("ORG. SPECIFICATION", 120),
          _buildHeaderCell("KEY\nCHAR", 50),
          _buildHeaderCell("EVALUATION", 100),
          _buildHeaderCell("INST ID NO", 80),
          _buildHeaderCell("OBSERVED DIMENSIONS", 400),
          _buildHeaderCell("REMARKS", 100),
        ],
      ),
    );
  }

  Widget _buildDataRow(
    int slNo,
    String orgLocation,
    String parameters,
    String specification,
    String keyChar,
    String evaluation,
    String instIdNo,
  ) {
    return Container(
      height: 35,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Row(
        children: [
          _buildDataCell(slNo.toString(), 60),
          _buildDataCell(orgLocation, 80),
          _buildDataCell(parameters, 150),
          _buildDataCell(specification, 120),
          _buildDataCell(keyChar, 50),
          _buildDataCell(evaluation, 100),
          _buildDataCell(instIdNo, 80),
          _buildObservedDimensionsGrid(),
          _buildDataCell("", 100),
        ],
      ),
    );
  }

  Widget _buildEmptyRow(int slNo) {
    return Container(
      height: 35,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Row(
        children: [
          _buildDataCell(slNo.toString(), 60),
          _buildDataCell("...............", 80),
          _buildDataCell("", 150),
          _buildDataCell("", 120),
          _buildDataCell("", 50),
          _buildDataCell("", 100),
          _buildDataCell("", 80),
          _buildObservedDimensionsGrid(),
          _buildDataCell("", 100),
        ],
      ),
    );
  }

  Widget _buildObservedDimensionsGrid() {
    return Container(
      width: 400,
      child: Row(
        children: List.generate(
          10,
          (index) => Expanded(
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black,
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

  Widget _buildConclusionRow() {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 0.5),
          bottom: BorderSide(color: Colors.black, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 500,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.black, width: 0.5),
              ),
            ),
            child: const Text(
              "CONCLUSION :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Container(
            width: 640,
            alignment: Alignment.center,
            child: const Text(
              "ALL DIMENSIONS ARE INSPECTED AND ACCEPTED",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterRow() {
    return Container(
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 0.5),
                        ),
                      ),
                      child: const Text(
                        "INSPECTED BY :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "DATE        :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 0.5),
                        ),
                      ),
                      child: const Text(
                        "VERIFIED BY :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "DATE        :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 0.5),
                        ),
                      ),
                      child: const Text(
                        "APPROVED BY :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "DATE        :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
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

  Widget _buildHeaderCell(String text, double width) {
    return Container(
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }

  Widget _buildDataCell(String text, double width) {
    return Container(
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      child: Text(
        text,
        style: const TextStyle(fontSize: 9),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
