import 'package:sqflite/sqflite.dart';
import '../models/book.dart';
import 'app_db.dart';

class BookDao {
  Future<int> insert(Book book) async {
    final db = await AppDatabase.database;

    return db.insert(
      'book',
      {
        'name': book.name,
        'tag': book.tag,
        'type': book.type,
        'synopsis': book.synopsis,
      },
    );
  }

  Future<void> update(Book book) async {
    final db = await AppDatabase.database;

    await db.update(
      'book',
      {'name': book.name,
        'tag': book.tag,
        'type': book.type,
        'synopsis': book.synopsis,
      },
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.database;

    await db.delete(
      'book',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Book>> getAll() async {
    final db = await AppDatabase.database;
    final result = await db.query('book');

    return result.map(_fromMap).toList();
  }

  Future<List<Book>> getByTag(List<String> tags) async {
    final db = await AppDatabase.database;

    final placeholders = tags.map((_) => '?').join(',');

    final result = await db.query(
      'book',
      where: 'tag IN ($placeholders)',
      whereArgs: tags,
    );

    return result.map(_fromMap).toList();
  }

  Book _fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      name: map['name'],
      tag: map['tag'],
      type: map['type'],
      synopsis: map['synopsis'],
    );
  }
}
