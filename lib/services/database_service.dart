import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import '../models/word_model.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'khmer.db');

    // Check if the database already exists
    final exists = await databaseExists(path);

    if (!exists) {
      // If the database does not exist, copy it from assets
      try {
        await Directory(dirname(path)).create(recursive: true);

        ByteData data = await rootBundle.load(join('assets', 'khmer.db'));
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        print('Error copying database: $e');
      }
    }

    return await openDatabase(path);
  }

  Future<List<Word>> fetchWords(String query) async {
    final db = await database;
    final result = await db.query(
      'Items',
      where: 'word LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((json) => Word.fromJson(json)).toList();
  }
}
