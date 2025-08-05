import 'package:flutter/material.dart';

class TableFormWidget extends StatelessWidget {
  const TableFormWidget({super.key});

  Widget buildTableCell({
    required String label,
    double? width,
    double? height,
    bool isHeader = false,
    bool hasEmptyBox = false,
  }) {
    return Container(
      width: width,
      height: height ?? 50,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      alignment: Alignment.centerLeft,
      child: hasEmptyBox
          ? const SizedBox() // empty box for user to fill
          : Text(
              label,
              style: TextStyle(
                fontSize: isHeader ? 12 : 10,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Header: Logo + Company Name
            Row(
              children: [
                Container(
                  width: 140,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                    child: Text(
                      'KFC',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Center(
                      child: Text(
                        'KOVAI FINE COAT (P) LIMITED',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// Subheader: Form Title
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: const Center(
                child: Text(
                  'SCRAP DISPOSAL FORM',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            /// Table using Row structure (7 rows × 4 columns)

            // Row 1
            Row(
              children: const [
                TableCell(label: 'SEQ NO.', width: 140),
                ExpandedEmptyCell(flex: 3),
                ExpandedTextCell(label: 'DATE', flex: 2),
                ExpandedEmptyCell(flex: 2),
              ],
            ),

            // Row 2
            Row(
              children: const [
                TableCell(label: 'NCR NO.', width: 140),
                ExpandedEmptyCell(flex: 3),
                ExpandedTextCell(label: 'DATE', flex: 2),
                ExpandedEmptyCell(flex: 2),
              ],
            ),

            // Row 3
            Row(
              children: const [
                TableCell(label: 'OPERATOR NAME', width: 140),
                ExpandedEmptyCell(flex: 3),
                ExpandedEmptyCell(flex: 2),
                ExpandedEmptyCell(flex: 2),
              ],
            ),

            // Row 4
            Row(
              children: const [
                TableCell(label: 'PART NAME', width: 140),
                ExpandedEmptyCell(flex: 3),
                ExpandedEmptyCell(flex: 2),
                ExpandedEmptyCell(flex: 2),
              ],
            ),

            // Row 5
            Row(
              children: const [
                TableCell(label: 'DRAWING NO.', width: 140),
                ExpandedEmptyCell(flex: 3),
                ExpandedTextCell(label: 'REV:', flex: 2),
                ExpandedEmptyCell(flex: 2),
              ],
            ),

            // Row 6
            Row(
              children: const [
                TableCell(label: 'ROUTE CARD NO.', width: 140),
                ExpandedEmptyCell(flex: 3),
                ExpandedEmptyCell(flex: 2),
                ExpandedEmptyCell(flex: 2),
              ],
            ),

            // Row 7
            Row(
              children: const [
                TableCell(label: 'REJECTION QTY.', width: 140),
                ExpandedEmptyCell(flex: 3),
                ExpandedTextCell(label: 'COST', flex: 2),
                ExpandedEmptyCell(flex: 2),
              ],
            ),

            /// REASON FOR NCR Section
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'REASON FOR NCR',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            /// Bottom signature section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ExpandedTableCell(label: "QA/QC SIGN"),
                ExpandedTableCell(label: "AUTHORISATION"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper widget for fixed width text cells (Column 1)
class TableCell extends StatelessWidget {
  final String label;
  final double width;

  const TableCell({required this.label, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// Helper widget for expanded text cells
class ExpandedTextCell extends StatelessWidget {
  final String label;
  final int flex;

  const ExpandedTextCell({required this.label, required this.flex, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// Helper widget for expanded empty cells
class ExpandedEmptyCell extends StatelessWidget {
  final int flex;

  const ExpandedEmptyCell({required this.flex, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 50,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      ),
    );
  }
}

/// Helper widget for expanded table cells with text
class ExpandedTableCell extends StatelessWidget {
  final String label;

  const ExpandedTableCell({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
