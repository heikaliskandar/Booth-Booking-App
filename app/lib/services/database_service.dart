import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BoothDB {
  static Database? _database;

  static Future<Database> connect() async {
    if (_database != null) return _database!;
    return _database = await _initDB();
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'booth.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE booth_info (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            phone TEXT, 
            areas TEXT,
            username TEXT,
            dateTime TEXT,
            quantity INTEGER,
            totalPrice REAL,
            additionalItems TEXT
          )
        """);
        await db.execute("""
          CREATE TABLE specialize_area (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            areas TEXT,
            imageUrl TEXT
          )
        """);
        await db.execute("""
          INSERT INTO specialize_area(areas, imageUrl)
          VALUES
          ('Basic Booth', 'assets/images/basic_booth.jpg'),
          ('Standard Booth', 'assets/images/standard_booth.jpg'),
          ('Premium Booth', 'assets/images/premium_booth.jpg'),
          ('Luxury Booth', 'assets/images/luxury_booth.jpg')
        """);
        await db.execute("""
          CREATE TABLE login (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            username TEXT,
            password TEXT,
            email TEXT,
            phone TEXT 
          )
        """);
        await db.execute("""
          CREATE TABLE admin (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            username TEXT,
            password TEXT,
            email TEXT,
            phone TEXT 
          )
        """);
      },
    );
  }
}
