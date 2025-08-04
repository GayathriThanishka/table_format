import 'package:kovaii_fine_coat/features/models/header_model.dart';

class FinalInspectionModel {
  final HeaderInfoModel headerInfo;
  final List<FinalInspection> finalInspection;

  FinalInspectionModel({required this.headerInfo, required this.finalInspection});
  List<List<String>> get qualityPlanTableData {
    return finalInspection
        .map(
          (plan) => [
            plan.serialNumber,
            plan.drgLocation,
            plan.parameters,
            plan.drgSpecification,
            plan.keyChar,
            plan.evaluation,
            plan.instIdNo,
            plan.observedDimensions,
            plan.remarks
          ],
        )
        .toList();
  }
}

class FinalInspection {
  final String serialNumber;
  final String drgLocation;
  final String parameters;
  final String drgSpecification;
  final String keyChar;
  final String evaluation;
  final String instIdNo;
  final String observedDimensions;
  final String remarks;

  FinalInspection({
    required this.serialNumber,
    required this.drgLocation,
    required this.parameters,
    required this.drgSpecification,
    required this.keyChar,
    required this.evaluation,
    required this.instIdNo,
    required this.observedDimensions,
    required this.remarks,
  });
}
