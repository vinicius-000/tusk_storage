import 'package:sqflite/sqflite.dart';
import '../models/manga.dart';
import 'app_db.dart';

class MangaDao {
  Future<int> insert(Manga manga) async {
    final db = await AppDatabase.database;

    return db.insert(
      'manga',
      {
        'name': manga.name,
        'weekday': manga.weekday,
        'chapter': manga.chapter,
        'recap': manga.recap,
        'tag': manga.tag,
        'type': manga.type,
        'synopsis': manga.synopsis,
      },
    );
  }

  Future<void> update(Manga manga) async {
    final db = await AppDatabase.database;

    await db.update(
      'manga',
      {'name': manga.name,
        'weekday': manga.weekday,
        'chapter': manga.chapter,
        'recap': manga.recap,
        'tag': manga.tag,
        'type': manga.type,
        'synopsis': manga.synopsis,
      },
      where: 'id = ?',
      whereArgs: [manga.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.database;

    await db.delete(
      'manga',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Manga>> getAll() async {
    final db = await AppDatabase.database;
    final result = await db.query('manga');

    return result.map(_fromMap).toList();
  }

  Future<List<Manga>> getByTag(List<String> tags,
      {bool onlyWithoutWeekday = false,}) async {
    final db = await AppDatabase.database;

    final placeholders = tags.map((_) => '?').join(',');

    final whereExtra = (onlyWithoutWeekday && tags.contains('Releasing'))
        ? 'AND manga.weekday IS NULL'
        : '';

    final result = await db.rawQuery('''
      SELECT * FROM manga
      WHERE tag IN ($placeholders) $whereExtra
    ''', tags);

    return result.map(_fromMap).toList();
  }

  Future<List<Manga>> getReleasingByWeekday(String day) async {
    final db = await AppDatabase.database;

    final result = await db.query(
      'manga',
      where: 'tag = ? AND weekday = ?',
      whereArgs: ['Releasing', day],
    );

    return result.map(_fromMap).toList();
  }

  Future<void> updateChapter(int id, double chap) async {
    final db = await AppDatabase.database;

    await db.update(
      'manga',
      {'chapter': chap},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Manga _fromMap(Map<String, dynamic> map) {
    return Manga(
      id: map['id'],
      name: map['name'],
      weekday: map['weekday'],
      chapter: map['chapter'],
      recap: map['recap'],
      tag: map['tag'],
      type: map['type'],
      synopsis: map['synopsis'],
    );
  }
}
