import 'dart:io';
import 'package:kovaii_fine_coat/features/models/parameters_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBService {
  static Database? _db;

  static Future<void> init() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, "parameters.db");

    _db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE parameters (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            drawing_number TEXT,
            parameter TEXT,
            specification TEXT,
            inst_id_no TEXT,
            evaluation TEXT
          )
          ''');
        },
      ),
    );
  }

  static Future<int> insertParameter(ParameterModel p) async {
    return await _db!.insert('parameters', p.toMap());
  }

  static Future<List<ParameterModel>> fetchAll() async {
    final results = await _db!.query('parameters');
    return results.map((r) => ParameterModel.fromMap(r)).toList();
  }

  /// ✅ Fetch parameters for a specific drawing number
  static Future<List<ParameterModel>> fetchByDrawing(String drawingNumber) async {
    final results = await _db!.query(
      'parameters',
      where: 'drawing_number = ?',
      whereArgs: [drawingNumber],
    );
    return results.map((r) => ParameterModel.fromMap(r)).toList();
  }

  static Future<void> clearTable() async {
    await _db!.delete('parameters');
  }
}
