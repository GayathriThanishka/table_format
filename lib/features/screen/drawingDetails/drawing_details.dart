import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kovaii_fine_coat/components/common_dropdown.dart';
import 'package:kovaii_fine_coat/components/common_filled_button.dart';
import 'package:kovaii_fine_coat/components/common_text_field.dart';
import 'package:kovaii_fine_coat/constant/app_strings.dart';
import 'package:kovaii_fine_coat/constant/images.dart';
import 'package:kovaii_fine_coat/csv/csv_loader.dart';
import 'package:kovaii_fine_coat/features/reports/final_inspection_pdf.dart';
import 'package:kovaii_fine_coat/features/reports/ncr_report.dart';
import 'package:kovaii_fine_coat/features/reports/raw_material_pdf.dart';
import 'package:kovaii_fine_coat/features/reports/rework_note.dart';
import 'package:kovaii_fine_coat/features/reports/route_card_report.dart';
import 'package:kovaii_fine_coat/features/reports/scrap_disposal.dart';
import 'package:kovaii_fine_coat/features/reports/stage_inspection_pdf.dart';
import 'package:kovaii_fine_coat/theme/palettes.dart';

class DrawingDetails extends StatefulWidget {
  const DrawingDetails({super.key});

  @override
  State<DrawingDetails> createState() => _DrawingDetailsState();
}

class _DrawingDetailsState extends State<DrawingDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controllers
  final TextEditingController drawingNoController = TextEditingController();
  final TextEditingController poNumberController = TextEditingController();
  final TextEditingController dcNumberController = TextEditingController();
  final TextEditingController minNumberController = TextEditingController();
  final TextEditingController lotQtyController = TextEditingController();
  final TextEditingController poDateController = TextEditingController();
  final TextEditingController dcDateController = TextEditingController();
  final TextEditingController routeCardNoController = TextEditingController();

  List<Map<String, String>> routeCardData = [];
  List<Map<String, String>> partDetails = [];
  String? selectedOperation;
  List<Map<String, String>> selectedOperations = [];

  String? selectedCustomer;
  String? selectedMaterial;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Add listeners to update right-side card in real-time
    drawingNoController.addListener(() => setState(() {}));
    poNumberController.addListener(() => setState(() {}));
    dcNumberController.addListener(() => setState(() {}));
    minNumberController.addListener(() => setState(() {}));
    lotQtyController.addListener(() => setState(() {}));
    poDateController.addListener(() => setState(() {}));
    dcDateController.addListener(() => setState(() {}));

    //load csv

    _loadCsv();
  }

  Future<void> _loadCsv() async {
    routeCardData = await loadCsvFile("assets/csv/routecard.csv");
    partDetails = await loadCsvFile("assets/csv/part_details.csv");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.logScreen),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(AppImages.logo),
                  SizedBox(width: 200),
                  Text(
                    AppStrings.companyName,
                    style: GoogleFonts.dmSans(
                      color: Palettes.primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DrawingDetails(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palettes.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh"),
                  ),
                  const SizedBox(width: 15),
                  // Logout button
                  ElevatedButton.icon(
                    onPressed: () {
                      exit(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text("Close"),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TabBar
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Palettes.whiteColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              labelColor: Palettes.primaryColor,
                              unselectedLabelColor: Palettes.textColor,
                              indicatorColor: Palettes.primaryColor,
                              tabs: const [
                                Tab(text: "Report Details"),
                                Tab(text: "RouteCard Details"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),

                          // TabBarView with only left form
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _buildReportDetailsForm(),
                                _buildRouteCardDetailsForm(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(flex: 1, child: _buildDrawingDetailsCard()),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Center(
                child: Text(
                  "POWERED BY @ ASTHRA",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Palettes.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _reportFormKey = GlobalKey<FormState>();
  final _routeCardFormKey = GlobalKey<FormState>();

  // Left side form
  Widget _buildReportDetailsForm() {
    print("partDetails: $partDetails");

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Palettes.whiteColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _reportFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      fieldWidth: 345,
                      labelText: "Drawing No",
                      hintText: "CNC18569324",
                      controller: drawingNoController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(_getDrawingName(drawingNoController.text)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CommonDropdown(
                      fieldWidth: 345,
                      labelText: "Material Specification",
                      items: const ["Aluminium", "Steel"],
                      selectedValue: selectedMaterial,
                      handleOnChange: (val) {
                        setState(() {
                          selectedMaterial = val;
                        });
                      },
                      hint: "Select material",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CommonDropdown(
                      fieldWidth: 345,
                      labelText: "Customer Name",
                      items: const ["LMW", "ABC", "XYZ"],
                      selectedValue: selectedCustomer,
                      handleOnChange: (val) {
                        setState(() {
                          selectedCustomer = val;
                        });
                      },
                      hint: "Select customer",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      fieldWidth: 345,
                      labelText: "P.O Number",
                      hintText: "PO8569",
                      controller: poNumberController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CommonTextField(
                      fieldWidth: 345,
                      labelText: "P.O Date",
                      hintText: "25/08/2025",
                      controller: poDateController,
                      icon: AppImages.calendar, // calendar svg
                      onSuffixTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        );
                        if (picked != null) {
                          poDateController.text =
                              "${picked.day}/${picked.month}/${picked.year}";
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      fieldWidth: 345,
                      labelText: "D.C No",
                      hintText: "DC6982",
                      controller: dcNumberController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CommonTextField(
                      fieldWidth: 345,
                      labelText: "D.C Date",
                      hintText: "25/08/2025",
                      controller: dcDateController,
                      icon: AppImages.calendar, // calendar svg
                      onSuffixTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        );
                        if (picked != null) {
                          dcDateController.text =
                              "${picked.day}/${picked.month}/${picked.year}";
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      fieldWidth: 345,
                      labelText: "MIN No",
                      hintText: "MIN963",
                      controller: minNumberController,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CommonTextField(
                      fieldWidth: 345,
                      labelText: "LOT Qty",
                      hintText: "89",
                      controller: lotQtyController,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDrawingName(String drawingNo) {
    if (drawingNo.isEmpty || partDetails.isEmpty) return "";

    final row = partDetails.firstWhere(
      (r) =>
          (r["Drawing #"] ?? "").trim().toLowerCase() ==
          drawingNo.trim().toLowerCase(),
      orElse: () => <String, String>{}, // return an empty Map
    );

    return row.isNotEmpty ? (row["Description"] ?? "") : "";
  }

  Widget _buildRouteCardDetailsForm() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Palettes.whiteColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _routeCardFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Route Card Number
              CommonTextField(
                fieldWidth: 345,
                labelText: "Route Card Number",
                hintText: "RCN-12345",
                controller: routeCardNoController,
              ),
              const SizedBox(height: 20),

              // Dropdown for Operation No (dynamic from CSV)
              CommonDropdown(
                fieldWidth: 345,
                labelText: "Operation No",
                items: routeCardData.map((row) => row["operation #"]!).toList(),
                selectedValue: selectedOperation,
                handleOnChange: (val) {
                  setState(() {
                    selectedOperation = val;

                    // Find the row in CSV
                    final row = routeCardData.firstWhere(
                      (r) => r["operation #"] == val,
                      orElse: () => {},
                    );

                    if (row.isNotEmpty &&
                        !selectedOperations.any(
                          (op) => op["operation #"] == val,
                        )) {
                      selectedOperations.add(row);
                    }
                  });
                },
                hint: "Select operation",
              ),
              const SizedBox(height: 20),

              // Show selected operations in a list
              Text(
                "Selected Operations",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),

              (selectedOperations ?? []).isEmpty
                  ? const Text("No operations selected")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedOperations.length,
                      itemBuilder: (context, index) {
                        final operation = selectedOperations[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              "Operation: ${operation["operation #"] ?? ""} | "
                              "Work Center: ${operation["Work center"] ?? ""} | "
                              "Parameters: ${operation["Parameters"] ?? ""}",
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Palettes.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedOperations.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Right side card
  Widget _buildDrawingDetailsCard() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Drawing Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildDetailItem("Drawing No", drawingNoController.text),
            SizedBox(height: 20),
            _buildDetailItem(
              "Drawing Name",
              _getDrawingName(drawingNoController.text),
            ),
            SizedBox(height: 20),
            _buildDetailItem("Customer Name", selectedCustomer ?? ""),
            SizedBox(height: 20),
            _buildDetailItem("Material", selectedMaterial ?? ""),
            SizedBox(height: 20),
            _buildDetailItem("P.O No", poNumberController.text),
            SizedBox(height: 20),
            _buildDetailItem("P.O Date", poDateController.text),
            SizedBox(height: 20),
            _buildDetailItem("D.C No", dcNumberController.text),
            SizedBox(height: 20),
            _buildDetailItem("D.C Date", dcDateController.text),
            SizedBox(height: 20),
            _buildDetailItem("Lot Qty", lotQtyController.text),
            SizedBox(height: 20),
            _buildDetailItem("MIN No", minNumberController.text),
            const SizedBox(height: 20),
            Center(
              child: CommonFilledButton(
                buttonWidth: 235,
                buttonText: 'Generate Report',
                handleOnTap: _handleGenerateReport,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleGenerateReport() async {
    bool isValid = false;

    if (_tabController.index == 0) {
      // Report Details tab
      isValid = _reportFormKey.currentState!.validate();
    } else if (_tabController.index == 1) {
      // RouteCard Details tab
      isValid = _routeCardFormKey.currentState!.validate();
    }

    if (!isValid) {
      _showPopup(context, "Please fill all required fields");
      return;
    }

    if (selectedOperations.isEmpty) {
      _showPopup(context, 'Select at least one operation');
      return;
    }

    try {
      await FinalInspectionReportGenerator.savePdf( drawingNo: drawingNoController.text,
        drawingName: _getDrawingName(drawingNoController.text),
        material: selectedMaterial ?? '',
        customer: selectedCustomer ?? '',
        operationNo: "", dataRows: [],);
      await StageInspectionReportGenerator.savePdf(
        drawingNo: drawingNoController.text,
        drawingName: _getDrawingName(drawingNoController.text),
        material: selectedMaterial ?? '',
        customer: selectedCustomer ?? '',
        operationNo: "", dataRows: [],
      );
      await RawMaterialInspectionPDF.savePDF(
        drawingNo: drawingNoController.text,
        drawingName: _getDrawingName(drawingNoController.text),
        poNumber: poNumberController.text,
        poDate: poDateController.text,
        dcNumber: dcNumberController.text,
        dcDate: dcDateController.text,
        minNumber: minNumberController.text,
        customer: selectedCustomer ?? '',
        material: selectedMaterial ?? '',
      );
      await ReworkNotePDF.savePDF(
        partName: _getDrawingName(drawingNoController.text),
        routeCardNo: routeCardNoController.text,
        partNumber: drawingNoController.text,
      );
      await ScrapDisposalFormPDF.savePDF(
        partName: _getDrawingName(drawingNoController.text),
        routeCardNo: routeCardNoController.text,
        partNumber: drawingNoController.text,
      );
      await NcrPdfGenerator.sharePDF();

      await RouteCardPdf.savePdf(
        routeCardNo: routeCardNoController.text,
        date: "",
        partName: _getDrawingName(drawingNoController.text),
        drawingNo: drawingNoController.text,
        drawingRevNo: "",
        poNo: poNumberController.text,
        poDate: poDateController.text,
        operations: selectedOperations
            .map(
              (op) => {
                "opNo": op["operation #"] ?? "",
                "wc": op["Work center"] ?? "",
                "param": op["Parameters"] ?? "",
              },
            )
            .toList(),
      );

      _showPopup(context, "Reports generated successfully");
    } catch (e) {
      _showPopup(context, "Error while generating PDFs: $e");
    }
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                color: Palettes.greyTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: TextStyle(color: Palettes.greyTextColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

void _showPopup(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
