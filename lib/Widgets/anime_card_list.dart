import 'package:flutter/material.dart';
import '../ButtonsAndStructures/card_list.dart';
import '../models/anime.dart';
import '../db/anime_dao.dart';
import 'anime_card.dart';

class AnimeCardList extends StatelessWidget {
  final List<String>? tagFilter;
  final String? weekday;
  final VoidCallback? onEdited;

  const AnimeCardList({
    super.key,
    this.tagFilter,
    this.weekday,
    this.onEdited,
  });

  @override
  Widget build(BuildContext context) {
    final dao = AnimeDao();

    return CardList<Anime>(
      load: () => _load(dao),
      itemBuilder: (anime) =>
          AnimeCard(anime: anime, onEdited: onEdited),
    );
  }

  Future<List<Anime>> _load(AnimeDao dao) {
    if (weekday != null) {
      return dao.getReleasingByWeekday(weekday!);
    }

    if (tagFilter != null) {
      return dao.getByTag(tagFilter!, onlyWithoutWeekday: true);
    }

    return dao.getAll();
  }
}
