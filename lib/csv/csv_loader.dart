import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:kovaii_fine_coat/db/db_service.dart';
import 'package:kovaii_fine_coat/features/models/parameters_model.dart';

/// Loads a CSV file from assets and converts it into a list of maps.
/// Each map represents a row, with keys as column headers.
Future<List<Map<String, String>>> loadCsvFile(String assetPath) async {
  try {
    final rawData = await rootBundle.loadString(assetPath);
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(rawData);

    if (csvTable.isEmpty) return [];

    // First row is header
    final headers = csvTable.first.map((h) => h.toString().trim()).toList();

    // Map rows with headers
    return csvTable.skip(1).map((row) {
      return Map<String, String>.fromIterables(
        headers,
        row.map((e) => e.toString().trim()),
      );
    }).toList();
  } catch (e) {
    // Handle errors gracefully
    print("Error reading CSV: $e");
    return [];
  }
}


Future<void> loadCsvToDb(String assetPath) async {
  final rawData = await rootBundle.loadString(assetPath);
  final List<List<dynamic>> csvTable = const CsvToListConverter().convert(rawData, eol: '\n');

  // Skip header row (row 0)
  for (int i = 1; i < csvTable.length; i++) {
    final row = csvTable[i];
    final model = ParameterModel(
      drawingNumber: row[0].toString(), // adjust index based on your CSV structure
      parameter: row[1].toString(),
      specification: row[2].toString(),
      instIdNo: row[3].toString(),
      evaluation: row[4].toString(),
    );
    await DBService.insertParameter(model);
  }
}
