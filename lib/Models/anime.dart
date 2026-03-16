class Anime {
  final int id;
  final String name;
  final String? weekday;
  final double? epNumber;
  final String tag;
  final String? type;
  final String? synopsis;

  Anime({
    required this.id,
    required this.name,
    this.weekday,
    this.epNumber,
    required this.tag,
    this.type,
    this.synopsis,
  });
}
