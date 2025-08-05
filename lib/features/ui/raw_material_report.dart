import 'package:flutter/material.dart';
import 'package:kovaii_fine_coat/features/components/report_components.dart';

class RawMaterialInspection extends StatelessWidget {
  const RawMaterialInspection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(),
                
                // Details Section
                _buildDetailsSection(),
                
                const SizedBox(height: 20), // Reduced from 50
                
                // Dimension Report Section
                _buildDimensionReportSection(),
                
                const SizedBox(height: 20),
                
                // Footer Section
                _buildFooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      children: [
        // KFC Logo Section
        Container(
          width: 140,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: Center(
            child: labelText1('KFC', isBold: true, isHeader: true),
          ),
        ),
        
        // Company Name and Title Section
        Expanded(
          flex: 4,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: labelText1(
                    'KOVAII FINE COAT (P) LIMITED',
                    isBold: true,
                    isHeader: true,
                  ),
                ),
                rowDivider1(),
                Center(
                  child: labelText1(
                    'RAW MATERIAL INSPECTION REPORT',
                    isBold: true,
                    isHeader: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // SI.NO Section
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
            ),
            child: Center(
              child: labelText1('SI.NO', isBold: true, isHeader: true),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column - Report Details
        Expanded(
          flex: 1,
          child: _buildLeftColumn(),
        ),
        
        const SizedBox(width: 200),
        
        // Middle Column - Additional Details
        Expanded(
          flex: 1,
          child: _buildMiddleColumn(),
        ),
        
        const SizedBox(width: 60),
        
        // Right Column - Visual Inspection
        SizedBox(
          width: 250,
          child: _buildVisualInspectionSection(),
        ),
        
        // Far Right Empty Column
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ],
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText1("REPORT NO", isBold: true, isHeader: true),
        labelText1("MIN NO:", isBold: true, isHeader: true),
        labelText1("CUSTOMER/SUPPLIER:", isBold: true, isHeader: true),
        labelText1("P.O NO & DATE", isBold: true, isHeader: true),
        labelText1("DESCRIPTION", isBold: true, isHeader: true),
        labelText1("DRAWING NO", isBold: true, isHeader: true),
        labelText1("MATERIAL SPEC", isBold: true, isHeader: true),
        labelText1("APPROVED SOURCE", isBold: true, isHeader: true),
      ],
    );
  }

  Widget _buildMiddleColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText1("DATE", isBold: true, isHeader: true),
        labelText1(""),
        labelText1(""),
        labelText1("D.C NO:", isBold: true, isHeader: true),
        labelText1("DATE:", isBold: true, isHeader: true),
        labelText1(""),
        labelText1("LOT QTY:", isBold: true, isHeader: true),
        labelText1("NA", isBold: true, isHeader: true),
      ],
    );
  }

  Widget _buildVisualInspectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText1("1.VISUAL INSPECTION:", isBold: true, isHeader: true),
        
        // Header Row
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              labelText1("DENT", isBold: true, isHeader: true),
              labelText1("DAMAGE", isBold: true, isHeader: true),
            ],
          ),
        ),
        
        // YES/NO Options Row 1
        Container(
          height: 40,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black),
              bottom: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              labelText1("YES", isBold: true, isHeader: true),
              verticalDivider1(),
              labelText1("NO", isBold: true, isHeader: true),
              verticalDivider1(),
              labelText1("YES", isBold: true, isHeader: true),
              verticalDivider1(),
              labelText1("NO", isBold: true, isHeader: true),
            ],
          ),
        ),
        
        // Empty Row
        Container(
          height: 40,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
            ),
          ),
        ),
        
        // BEND/OTHERS Header Row
        Container(
          height: 40,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black),
              bottom: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              labelText1("BEND", isBold: true, isHeader: true),
              verticalDivider1(),
              labelText1("OTHERS", isBold: true, isHeader: true),
            ],
          ),
        ),
        
        // YES/NO Options Row 2
        Container(
          height: 40,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black),
              bottom: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              labelText1("YES", isBold: true, isHeader: true),
              verticalDivider1(),
              labelText1("NO", isBold: true, isHeader: true),
              verticalDivider1(),
              labelText1("YES", isBold: true, isHeader: true),
              verticalDivider1(),
              labelText1("NO", isBold: true, isHeader: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDimensionReportSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText1("2. DIMENSION REPORT:", isBold: true, isHeader: true),
        const SizedBox(height: 5),
        // Center the table
         _buildDimensionTable(),
      ],
    );
  }

  Widget _buildDimensionTable() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table Header
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, 
            children: [
              _buildTableHeaderCell("SL NO", 85),
              _buildTableHeaderCell("DRG.\nDIMENSION", 400),
              _buildTableHeaderCell("OBSERVED\nDIMENSION", 253),
              _buildTableHeaderCell("EVALUATION", 253),
              _buildTableHeaderCell("REMARK", 253),
            ],
          ),
        ),
        
        // Table Data Row
        Container(
          height: 200,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 0.5),
              left: BorderSide(color: Colors.black, width: 0.5),
              right: BorderSide(color: Colors.black, width: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, 
            children: [
              _buildTableDataCell("1", 85),
              _buildTableDataCell("", 400),
              _buildTableDataCell("", 253),
              _buildTableDataCell("", 253),
              _buildTableDataCell("", 253),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeaderCell(String text, double width) {
    return Container(
      width: width,
      height: double.infinity,
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _buildTableDataCell(String text, double width) {
    return Container(
      width: width,
      height: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
          maxLines: 10,
        ),
      ),
    );
  }

  Widget _buildFooterSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText1("ACC QTY", isHeader: true, isBold: true),
                labelText1("INSPECTED BY", isHeader: true, isBold: true),
                labelText1("DATE", isHeader: true, isBold: true),
              ],
            ),
          ),
          
          const SizedBox(width: 100),
          
          // Middle Column
          Expanded(
            flex: 1,
            child: labelText1("REWORK QTY", isHeader: true, isBold: true),
          ),
          
          const SizedBox(width: 100),
          
          // Right Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText1("REJ QTY", isHeader: true, isBold: true),
                labelText1("APPROVED BY", isHeader: true, isBold: true),
                labelText1("DATE", isHeader: true, isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}