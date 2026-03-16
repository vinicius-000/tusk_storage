import 'package:sqflite/sqflite.dart';
import '../models/pokemon_solo.dart';
import 'app_db.dart';

class PokemonSoloDao {
  Future<int> insert(PokemonSolo pkmnSolo) async {
    final db = await AppDatabase.database;

    return db.insert(
      'pokemon_solo',
      {
        'game': pkmnSolo.game,
        'pokemon': pkmnSolo.pokemon,
        'champion_level': pkmnSolo.championLevel,
        'champion_time': pkmnSolo.championTime,
        'post_level': pkmnSolo.postLevel,
        'post_time': pkmnSolo.postTime,
        'color': pkmnSolo.color,
        'text_color': pkmnSolo.textColor,
        'extra': pkmnSolo.extra,
      },
    );
  }

  Future<void> update(PokemonSolo pkmnSolo) async {
    final db = await AppDatabase.database;

    await db.update(
      'pokemon_solo',
      {
        'game': pkmnSolo.game,
        'pokemon': pkmnSolo.pokemon,
        'champion_level': pkmnSolo.championLevel,
        'champion_time': pkmnSolo.championTime,
        'post_level': pkmnSolo.postLevel,
        'post_time': pkmnSolo.postTime,
        'color': pkmnSolo.color,
        'text_color': pkmnSolo.textColor,
        'extra': pkmnSolo.extra,
      },
      where: 'id = ?',
      whereArgs: [pkmnSolo.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.database;

    await db.delete(
      'pokemon_solo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<PokemonSolo>> getAll() async {
    final db = await AppDatabase.database;
    final result = await db.query('pokemon_solo');

    return result.map(_fromMap).toList();
  }

  PokemonSolo _fromMap(Map<String, dynamic> map) {
    return PokemonSolo(
      id: map['id'],
      game: map['game'],
      pokemon: map['pokemon'],
      championLevel: map['champion_level'],
      championTime: map['champion_time'],
      postLevel: map['post_level'],
      postTime: map['post_time'],
      color: map['color'],
      textColor: map['text_color'],
      extra: map['extra'],
    );
  }
}
