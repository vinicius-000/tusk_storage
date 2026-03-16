class Manga {
  final int id;
  final String name;
  final String? weekday;
  final double? chapter;
  final String? recap;
  final String tag;
  final String? type;
  final String? synopsis;

  Manga({
    required this.id,
    required this.name,
    this.weekday,
    this.chapter,
    this.recap,
    required this.tag,
    this.type,
    this.synopsis,
  });
}
