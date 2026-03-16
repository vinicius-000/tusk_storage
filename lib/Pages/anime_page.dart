import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/releasing_weekday_section.dart';
import '../ButtonsAndStructures/titles.dart';
import '../ButtonsAndStructures/filter_selector.dart';
import '../DB/static_values.dart';
import '../Widgets/anime_card_list.dart';
import '../models/anime.dart';
import '../widgets/anime_card.dart';
import '../pages/add_anime_page.dart';
import '../db/anime_dao.dart';
import '../widgets/app_drawer.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  final AnimeDao dao = AnimeDao();
  String? selectedTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(current: AnimePage),
      appBar: AppBar(
        title: const Text('Anime'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          AddButton(
            label: 'Add Anime',
            pageBuilder: (_) => const AddAnimePage(),
            onReturn: () => setState(() {}),
          ),

          const SizedBox(height: 16),

          TagFilterSelector(
            tags: Tags.animeTags,
            selected: selectedTag,
            onChanged: (tag) {
              setState(() {
                selectedTag = tag;
              });
            },
          ),

          const SizedBox(height: 16),

          // Anime cards sections

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'Releasing') ...[
            SectionTitle.text('Weekly Anime'),
            _weekdaySection(),

            const SizedBox(height: 16),

            // Anime cards sections
            SectionTitle.text('Releasing'),
            AnimeCardList(
              tagFilter: ['Releasing'],
              onEdited: _reload,
            ),
          ],

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'Watching') ...[
            SectionTitle.text('Watching'),
            AnimeCardList(
              tagFilter: ['Watching'],
              onEdited: _reload,
            ),
          ],

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'Paused') ...[
            SectionTitle.text('Paused'),
            AnimeCardList(
              tagFilter: ['Paused'],
              onEdited: _reload,
            ),
          ],

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'To Watch') ...[
            SectionTitle.text('To Watch'),
            AnimeCardList(
              tagFilter: ['To Watch'],
              onEdited: _reload,
            ),
          ],

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'Finished') ...[
            SectionTitle.text('Finished'),
            AnimeCardList(
              tagFilter: ['Finished'],
              onEdited: _reload,
            ),
          ],

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Current weekly anime section
  Widget _weekdaySection() {
    return ReleasingWeekdaySection<Anime>(
      future: dao.getAll(),
      days: Weekday.weekdays,
      getWeekday: (a) => a.weekday,
      getTag: (a) => a.tag,
      itemBuilder: (anime, {onEdited}) =>
          AnimeCard(anime: anime, onEdited: onEdited),
      onEdited: () => setState(() {}),
    );
  }

  void _reload() {
    setState(() {});
  }
}
