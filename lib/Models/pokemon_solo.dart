class PokemonSolo {
  final int id;
  final String game;
  final String pokemon;
  final int? championLevel;
  final int? championTime;
  final int? postLevel;
  final int? postTime;
  final int color;
  final int textColor;
  final String? extra;

  PokemonSolo({
    required this.id,
    required this.game,
    required this.pokemon,
    this.championLevel,
    this.championTime,
    this.postLevel,
    this.postTime,
    required this.color,
    required this.textColor,
    this.extra,
  });
}
