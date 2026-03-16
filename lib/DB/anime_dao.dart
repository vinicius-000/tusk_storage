import 'package:sqflite/sqflite.dart';
import '../models/anime.dart';
import 'app_db.dart';

class AnimeDao {
  Future<int> insert(Anime anime) async {
    final db = await AppDatabase.database;

    return db.insert(
      'anime',
      {
        'name': anime.name,
        'weekday': anime.weekday,
        'ep_number': anime.epNumber,
        'tag': anime.tag,
        'type': anime.type,
        'synopsis': anime.synopsis,
      },
    );
  }

  Future<void> update(Anime anime) async {
    final db = await AppDatabase.database;

    await db.update(
      'anime',
      {'name': anime.name,
        'weekday': anime.weekday,
        'ep_number': anime.epNumber,
        'tag': anime.tag,
        'type': anime.type,
        'synopsis': anime.synopsis,
      },
      where: 'id = ?',
      whereArgs: [anime.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.database;

    await db.delete(
      'anime',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Anime>> getAll() async {
    final db = await AppDatabase.database;
    final result = await db.query('anime');

    return result.map(_fromMap).toList();
  }

  Future<List<Anime>> getByTag(List<String> tags,
      {bool onlyWithoutWeekday = false,}) async {
    final db = await AppDatabase.database;

    final placeholders = tags.map((_) => '?').join(',');

    final whereExtra = (onlyWithoutWeekday && tags.contains('Releasing'))
        ? 'AND anime.weekday IS NULL'
        : '';

    final result = await db.rawQuery('''
      SELECT * FROM anime
      WHERE tag IN ($placeholders) $whereExtra
    ''', tags);

    return result.map(_fromMap).toList();
  }

  Future<List<Anime>> getReleasingByWeekday(String day) async {
    final db = await AppDatabase.database;

    final result = await db.query(
      'anime',
      where: 'tag = ? AND weekday = ?',
      whereArgs: ['Releasing', day],
    );

    return result.map(_fromMap).toList();
  }

  Future<void> updateEpisode(int id, double ep) async {
    final db = await AppDatabase.database;

    await db.update(
      'anime',
      {'ep_number': ep},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Anime _fromMap(Map<String, dynamic> map) {
    return Anime(
      id: map['id'],
      name: map['name'],
      weekday: map['weekday'],
      epNumber: map['ep_number'],
      tag: map['tag'],
      type: map['type'],
      synopsis: map['synopsis'],
    );
  }
}
