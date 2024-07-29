import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:task/model/model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), 'app_data.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE data (
        id INTEGER PRIMARY KEY,
        json TEXT
      )
    ''');
  }

  Future<void> insertData(String json) async {
    Database db = await database;
    await db.insert(
      'data',
      {'json': json},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Model>> fetchData() async {
    Database db = await database;
    final List<Map<String, dynamic>> result = await db.query('data');

    if (result.isNotEmpty) {
      return FromJson(result.first['json']);
    } else {
      return [];
    }
  }
}
