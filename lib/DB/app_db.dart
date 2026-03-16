import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'storage.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    // ---------- TAGS ----------
    await db.execute('''
      CREATE TABLE read_tag (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    // ---------- ANIME ----------
    await db.execute('''
      CREATE TABLE anime (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        weekday TEXT,
        ep_number REAL,
        tag TEXT NOT NULL,
        type TEXT,
        synopsis TEXT
      );
    ''');

    // ---------- MANGA ----------
    await db.execute('''
      CREATE TABLE manga (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        weekday TEXT,
        chapter REAL,
        recap TEXT,
        tag TEXT NOT NULL,
        type TEXT,
        synopsis TEXT
      );
    ''');

    // ---------- MOVIES ----------
    await db.execute('''
      CREATE TABLE movie (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT,
        synopsis TEXT
      );
    ''');

    // ---------- BOOKS ----------
    await db.execute('''
      CREATE TABLE book (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        tag TEXT NOT NULL,
        type TEXT,
        synopsis TEXT
      );
    ''');

    // ---------- POKEMON MONOTYPE ----------
    await db.execute('''
      CREATE TABLE pokemon_monotype (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        game TEXT NOT NULL,
        type TEXT NOT NULL,
        pokemon_list TEXT NOT NULL
      );
    ''');

    // ---------- POKEMON SOLO ----------
    await db.execute('''
      CREATE TABLE pokemon_solo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        game TEXT NOT NULL,
        pokemon TEXT NOT NULL,
        champion_level INTEGER,
        champion_time INTEGER,
        post_level INTEGER,
        post_time INTEGER,
        color INTEGER NOT NULL,
        text_color INTEGER NOT NULL,
        extra TEXT
      );
    ''');

    // ---------- INITIAL DATA ----------
    await _insertInitialData(db);
  }

  static Future<void> _insertInitialData(Database db) async {
  }

  static Future<void> deleteDatabaseManually() async {
    final path = await getDatabasesPath();
    await deleteDatabase('$path/storage.db');
    debugPrint('DATABASE DELETED');
  }
}
