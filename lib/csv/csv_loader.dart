import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

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
