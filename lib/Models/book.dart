class Book {
  final int id;
  final String name;
  final String tag;
  final String? type;
  final String? synopsis;

  Book({
    required this.id,
    required this.name,
    required this.tag,
    this.type,
    this.synopsis,
  });
}
