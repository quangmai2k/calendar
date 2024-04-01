import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'calendar';
  static const String tableName = 'events';
  static const String columnId = 'id';
  static const String columnEventNote = 'event';
  static const String columnStart = 'startTime';
  static const String columnEnd = 'endTime';
  static const String columnColor = 'color';
  static const String columnIsAllDay = 'isAllDay';

  static DatabaseHelper? _instance;

  DatabaseHelper._(); // Private constructor

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $tableName(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnEventNote TEXT,
          $columnStart INTERGER,
          $columnEnd INTERGER,
          $columnColor TEXT,
          $columnIsAllDay INTERGER
        )
      ''');
    });
  }

  Future<int> insertData(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAllData() async {
    Database db = await database;
    return await db.query(tableName);
  }
}

void main() async {
  var dbHelper = DatabaseHelper();

  // Initialize database
  await dbHelper.initDatabase();
  DateTime start = DateTime.now().add(Duration(hours: 1));
  DateTime end = DateTime.now().add(Duration(hours: 3));

  // Insert data
  await dbHelper.insertData({
    DatabaseHelper.columnEventNote: 'Đi ăn tối',
    DatabaseHelper.columnStart: start.microsecondsSinceEpoch,
    DatabaseHelper.columnEnd: end.microsecondsSinceEpoch,
    DatabaseHelper.columnColor: '#ED9389'
  });

  // Query all data
  List<Map<String, dynamic>> rows = await dbHelper.queryAllData();
  print(rows);
}
