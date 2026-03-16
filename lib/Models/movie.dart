class Movie {
  final int id;
  final String name;
  final String? type;
  final String? synopsis;

  Movie({
    required this.id,
    required this.name,
    this.type,
    this.synopsis,
  });
}
