import 'package:sqflite/sqflite.dart';
import '../models/movie.dart';
import 'app_db.dart';

class MovieDao {
  Future<int> insert(Movie movie) async {
    final db = await AppDatabase.database;

    return db.insert(
      'movie',
      {
        'name': movie.name,
        'type': movie.type,
        'synopsis': movie.synopsis,
      },
    );
  }

  Future<void> update(Movie movie) async {
    final db = await AppDatabase.database;

    await db.update(
      'movie',
      {'name': movie.name,
        'type': movie.type,
        'synopsis': movie.synopsis,
      },
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.database;

    await db.delete(
      'movie',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Movie>> getAll() async {
    final db = await AppDatabase.database;
    final result = await db.query('movie');

    return result.map(_fromMap).toList();
  }

  Future<List<Movie>> getByTag(List<String> tags) async {
    final db = await AppDatabase.database;

    final placeholders = tags.map((_) => '?').join(',');

    final result = await db.query(
      'movie',
      where: 'tag IN ($placeholders)',
      whereArgs: tags,
    );

    return result.map(_fromMap).toList();
  }

  Movie _fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      synopsis: map['synopsis'],
    );
  }
}
