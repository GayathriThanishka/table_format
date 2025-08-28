import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

labelText(
  String text, {
  bool isHeader = false,
  PdfColor textColor = PdfColors.black,
  bool isBold = false,
  bool isletterSpacing = false,
}) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(left: 5, top: 4, bottom: 4),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        letterSpacing: isletterSpacing ? 2.0 : 0,
        fontSize: isHeader ? 15 : 8,
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        color: textColor,
      ),
    ),
  );
}

pw.Widget labelTextSubHead(
  String text, {
  PdfColor textColor = PdfColors.black,
  bool isBold = false,
  bool isTableHeader=false
}) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(left: 2, top: 4, bottom: 4),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: isTableHeader?9:10,
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        color: textColor,
      ),
    ),
  );
}

divider({PdfColor? dividerColor}) {
  return pw.Divider(height: 1, color: dividerColor ?? PdfColors.black);
}

verticalDivider({double? h = 200}) {
  return pw.Container(width: .5, height: h, color: PdfColors.black);
}

pw.Widget rowDivider({
  double width = double.infinity,
  double thickness = 0.5,
  PdfColor color = PdfColors.black,
}) {
  return pw.Container(width: width, height: thickness, color: color);
}

pw.Widget splitHorizontalDivider({
  double thickness = 0.5,
  PdfColor color = PdfColors.black,
  double gapWidth = 100,
}) {
  return pw.Row(
    children: [
      pw.Container(height: thickness, color: color, width: 200),
      pw.SizedBox(width: gapWidth),
      pw.Expanded(
        child: pw.Container(height: thickness, color: color),
      ),
    ],
  );
}

//global footer

pw.Widget globalFooter({
  PdfColor textColor = PdfColors.black,
  bool isBold = false,
}) {
  return pw.Container(
    alignment: pw.Alignment.center,
    child: pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Text(
          'QNote Powered by ',
          style: pw.TextStyle(
            fontSize: 8,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: textColor,
          ),
        ),
        pw.Text(
          ' @Asthra',
          style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget labelText1(String text, {bool isBold = false, bool isHeader = false}) {
  return Padding(
    padding: EdgeInsets.only(left: 5, top: 4, bottom: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: isHeader ? 13 : 10,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: Colors.black,
      ),
    ),
  );
}

Widget divider1() {
  return Divider(height: 1, color: Colors.black);
}

Widget rowDivider1({
  double width = double.infinity,
  double thickness = 0.5,
  Color color = Colors.black,
}) {
  return Container(width: width, height: thickness, color: color);
}

Widget verticalDivider1({double h = 80}) {
  return Container(width: 0.5, height: h, color: Colors.black);
}
