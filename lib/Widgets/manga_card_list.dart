import 'package:flutter/material.dart';
import '../ButtonsAndStructures/card_list.dart';
import '../models/manga.dart';
import '../db/manga_dao.dart';
import 'manga_card.dart';

class MangaCardList extends StatelessWidget {
  final List<String>? tagFilter;
  final String? weekday;
  final VoidCallback? onEdited;

  const MangaCardList({
    super.key,
    this.tagFilter,
    this.weekday,
    this.onEdited,
  });

  @override
  Widget build(BuildContext context) {
    final dao = MangaDao();

    return CardList<Manga>(
      load: () => _load(dao),
      itemBuilder: (manga) =>
          MangaCard(manga: manga, onEdited: onEdited),
    );
  }

  Future<List<Manga>> _load(MangaDao dao) {
    if (weekday != null) {
      return dao.getReleasingByWeekday(weekday!);
    }

    if (tagFilter != null) {
      return dao.getByTag(tagFilter!, onlyWithoutWeekday: true);
    }

    return dao.getAll();
  }
}
