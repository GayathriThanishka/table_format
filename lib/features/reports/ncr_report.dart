import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kovaii_fine_coat/features/report_components/report_components.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class NcrPdfGenerator {
  static Future<Uint8List> generateNCRPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        //orientation:pw.PageOrientation.landscape,
        margin: const pw.EdgeInsets.all(16),
        build: (pw.Context context) {
          return [
            // Main container with border
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 2),
              ),
              child: pw.Column(
                children: [
                  // Header row with kfc logo and company name
                  pw.Container(
                    height: 60,
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                right: pw.BorderSide(color: PdfColors.black, width: 1),
                                bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                              ),
                            ),
                            child: pw.Center(
                              child: labelText(
                                'kfc',isBold: true,isHeader: true
                               
                              ),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                              ),
                            ),
                            child: pw.Center(
                              child: labelText(
                                'KOVAII FINE COAT ( P ) LIMITED',isHeader: true,isletterSpacing: true,isBold: true,
                                
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Second header row
                  pw.Container(
                    height: 40,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                      ),
                    ),
                    child: pw.Center(
                      child:labelText(
                        'NON CONFORMITY REPORT / CORRECTIVE AND PREVENTIVE ACTION REPORT ( INPROCESS/FINAL/ CUSTOMER )',isBold: true
                        
                      ),
                    ),
                  ),
                  
                  // Third header row
                  pw.Container(
                    height: 30,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                      ),
                    ),
                    child: pw.Center(
                      child:labelText(
                        '( FOR CONCESSIONAL ACCEPTANCE / REJECTION )',isBold: true,
                        
                      ),
                    ),
                  ),
                  
                  // First data row - NCR NO, DATE, DEPARTMENT
                  pw.Container(
                    height: 35,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('NCR NO', flex: 2),
                        _buildPDFCell('', flex: 3),
                        _buildPDFCell('DATE', flex: 1),
                        _buildPDFCell('', flex: 2),
                        _buildPDFCell('DEPARTMENT', flex: 2),
                        _buildPDFCell('', flex: 2),
                      ],
                    ),
                  ),
                  
                  // Second data row - ITEM NAME, ROUTE CARD NO
                  pw.Container(
                    height: 35,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('ITEM NAME', flex: 2),
                        _buildPDFCell('PAINTING COOLER', flex: 6),
                        _buildPDFCell('ROUTE CARD NO', flex: 2),
                        _buildPDFCell('-', flex: 2),
                      ],
                    ),
                  ),
                  
                  // Third data row - DRAWING NO, REV NO, INS.REPORT NO
                  pw.Container(
                    height: 35,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('DRAWING NO', flex: 2),
                        _buildPDFCell('', flex: 3),
                        _buildPDFCell('REV NO', flex: 1),
                        _buildPDFCell('-', flex: 1),
                        _buildPDFCell('INS.REPORT NO', flex: 2),
                        _buildPDFCell('', flex: 3),
                      ],
                    ),
                  ),
                  
                  // Fourth data row - MATERIAL, INSP. QTY, NC.QTY
                  pw.Container(
                    height: 35,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('MATERIAL', flex: 2),
                        _buildPDFCell('', flex: 5),
                        _buildPDFCell('INSP. QTY', flex: 2),
                        _buildPDFCell('', flex: 1),
                        _buildPDFCell('NC.QTY', flex: 1),
                        _buildPDFCell('', flex: 1),
                      ],
                    ),
                  ),
                  
                  // Fifth data row - NC ITEM ID.NO
                  pw.Container(
                    height: 35,
                    child: pw.Row(children: [_buildPDFCell('NC ITEM ID.NO', flex: 12)]),
                  ),
                  
                  // Sixth data row - PROCESS SHEET NO, REV NO, CUSTOMER
                  pw.Container(
                    height: 35,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('PROCESS SHEET NO', flex: 2),
                        _buildPDFCell('-', flex: 3),
                        _buildPDFCell('REV NO', flex: 1),
                        _buildPDFCell('-', flex: 1),
                        _buildPDFCell('CUSTOMER', flex: 2),
                        _buildPDFCell('', flex: 3),
                      ],
                    ),
                  ),
                  
                  // Seventh data row - TYPE INSPECTION
                  pw.Container(
                    height: 35,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('TYPE INSPECTION :', flex: 2),
                        _buildPDFCell('IN HOUSE', flex: 2),
                        _buildPDFCell('BOUGHTOUT', flex: 2),
                        _buildPDFCell('SUB CONTRACT', flex: 2),
                        _buildPDFCell('CUSTOMER COMPLAINT', flex: 4),
                      ],
                    ),
                  ),
                  
                  // Eighth data row - PROCESS STAGE, OPERATION NO
                  pw.Container(
                    height: 35,
                    child: pw.Row(
                      children: [
                        _buildPDFCell(
                          'PROCESS STAGE : RAW MATERIAL / PROOF MACHINING /FINAL MACHINING/OTHERS',
                          flex: 10,
                        ),
                        _buildPDFCell('OPERATION NO :', flex: 2),
                        _buildPDFCell(' ', flex: 2),

                      ],
                    ),
                  ),
                   pw.Container(
                    height: 1,
                    color: PdfColors.black,
                  ),
                  
                  // Images section
                  pw.Container(
                    height: 200,
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: labelText(
                              'DEVIATION OBSERVED :',isBold: true
                              
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 50),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.grey300),
                            ),
                            child: pw.Center(
                              child: labelText(
                                'Image 1\n(Engineering Drawing)',
                               
                              ),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.grey300),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                'Image 2\n(Technical Drawing)',
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Divider
                  pw.Container(
                    height: 1,
                    color: PdfColors.black,
                  ),
                  
                  // Dimension serial no row
                  pw.Container(
                    height: 35,
                    child: pw.Row(
                      children: [_buildPDFCell('DIMENSION SERIAL NO :', flex: 12)],
                    ),
                  ),
                  
                  // Inspector signature row
                  pw.Container(
                    height: 40,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('INSPECTOR NAME', flex: 2),
                        _buildPDFCell('DULAL DUTTA', flex: 3),
                        _buildPDFCell('', flex: 2),
                        _buildPDFCell('', flex: 2),
                        _buildPDFCell('DATE', flex: 1),
                        _buildPDFCell('', flex: 2),
                      ],
                    ),
                  ),
                  
                  // HOD signature row
                  pw.Container(
                    height: 40,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('NAME OF HOD', flex: 2),
                        _buildPDFCell('', flex: 3),
                        _buildPDFCell('SIGNATURE', flex: 2),
                        _buildPDFCell('', flex: 2),
                        _buildPDFCell('DATE', flex: 1),
                        _buildPDFCell('', flex: 2),
                      ],
                    ),
                  ),
                  
                  // Approved by signature row
                  pw.Container(
                    height: 40,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('APPROVED BY', flex: 2),
                        _buildPDFCell('', flex: 3),
                        _buildPDFCell('SIGNATURE', flex: 2),
                        _buildPDFCell('', flex: 2),
                        _buildPDFCell('DATE', flex: 1),
                        _buildPDFCell('', flex: 2),
                      ],
                    ),
                  ),
                  
                  // Route cause section
                  pw.Container(
                    height: 150,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                      ),
                    ),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child:labelText(
                              'ROUTE CAUSE : ',isBold: true
                             
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Corrective action section
                  pw.Container(
                    height: 150,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                      ),
                    ),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child:labelText(
                              'CORRECTIVE ACTION : ',isBold: true
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Preventive action section
                  pw.Container(
                    height: 150,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                      ),
                    ),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: labelText(
                              'PREVENTIVE ACTION : ',
                              isBold: true
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Disposition action section
                  pw.Container(
                    height: 150,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                      ),
                    ),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: labelText(
                              'DISPOSITION ACTION : ',isBold: true
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Verification section
                  pw.Container(
                    height: 150,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                      ),
                    ),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: labelText(
                              'VERIFICATION ON EFFECTIVENESS OF CORRECTIVE ACTION / PREVENTIVE ACTION : ',
                              isBold: true
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // First verification signature
                  pw.Container(
                    height: 40,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('VERIFIED BY (NAME)', flex: 2),
                        _buildPDFCell('', flex: 3),
                        _buildPDFCell('SIGNATURE:', flex: 4),
                        _buildPDFCell('DATE', flex: 1),
                        _buildPDFCell('', flex: 2),
                      ],
                    ),
                  ),
                  
                  // Reference verification section
                  pw.Container(
                    height: 150,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black, width: 1),
                      ),
                    ),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: labelText(
                              'REFERENCE FOR VERIFICATION:',
                              isBold: true
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Second verification signature
                  pw.Container(
                    height: 40,
                    child: pw.Row(
                      children: [
                        _buildPDFCell('VERIFIED BY (NAME)', flex: 2),
                        _buildPDFCell('', flex: 3),
                        _buildPDFCell('SIGNATURE:', flex: 4),
                        _buildPDFCell('DATE', flex: 1),
                        _buildPDFCell('', flex: 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildPDFCell(String text, {int flex = 1}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(
        height: double.infinity,
        padding: const pw.EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        decoration: const pw.BoxDecoration(
          border: pw.Border(
            right: pw.BorderSide(color: PdfColors.black, width: 1),
            bottom: pw.BorderSide(color: PdfColors.black, width: 1),
          ),
        ),
        child:pw.Align(alignment: pw.Alignment.center,child: pw.Text(
            text,
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.normal),
            maxLines: 2,
          ),)
       
          
        
      ),
    );
  }



  // Method to print PDF
  static Future<void> printPDF() async {
    final pdfBytes = await generateNCRPDF();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }

  // Method to share PDF
  static Future<void> sharePDF() async {
    final pdfBytes = await generateNCRPDF();
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'NCR_Form.pdf',
    );
  }
}

// Widget to use the PDF generator
