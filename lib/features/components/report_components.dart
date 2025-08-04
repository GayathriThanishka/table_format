import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

labelText(
  String text, {

  PdfColor textColor = PdfColors.black,
  bool isBold = false,
}) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(left: 5, top: 4, bottom: 4),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 10,
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        color: textColor,
      ),
    ),
  );
}

pw.Widget labelTextSmall(
  String text, {
  PdfColor textColor = PdfColors.black,
  bool isBold = false,
}) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(left: 2, top: 4, bottom: 4),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 7,
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
