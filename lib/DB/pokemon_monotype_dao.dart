import 'package:sqflite/sqflite.dart';
import '../models/pokemon_monotype.dart';
import 'app_db.dart';

class PokemonMonotypeDao {
  Future<int> insert(PokemonMonotype pkmnMono) async {
    final db = await AppDatabase.database;

    return db.insert(
      'pokemon_monotype',
      {
        'game': pkmnMono.game,
        'type': pkmnMono.type,
        'pokemon_list': pkmnMono.pokemon_list,
      },
    );
  }

  Future<void> update(PokemonMonotype pkmnMono) async {
    final db = await AppDatabase.database;

    await db.update(
      'pokemon_monotype',
      {
        'game': pkmnMono.game,
        'type': pkmnMono.type,
        'pokemon_list': pkmnMono.pokemon_list,
      },
      where: 'id = ?',
      whereArgs: [pkmnMono.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.database;

    await db.delete(
      'pokemon_monotype',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<PokemonMonotype>> getAll() async {
    final db = await AppDatabase.database;
    final result = await db.query('pokemon_monotype');

    return result.map(_fromMap).toList();
  }

  PokemonMonotype _fromMap(Map<String, dynamic> map) {
    return PokemonMonotype(
      id: map['id'],
      game: map['game'],
      type: map['type'],
      pokemon_list: map['pokemon_list'],
    );
  }
}
