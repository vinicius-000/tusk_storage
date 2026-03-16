import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/releasing_weekday_section.dart';
import '../ButtonsAndStructures/titles.dart';
import '../ButtonsAndStructures/filter_selector.dart';
import '../Widgets/manga_card_list.dart';
import '../models/manga.dart';
import '../widgets/manga_card.dart';
import '../pages/add_manga_page.dart';
import '../db/manga_dao.dart';
import '../widgets/app_drawer.dart';
import '../DB/static_values.dart';

class MangaPage extends StatefulWidget {
  const MangaPage({super.key});

  @override
  State<MangaPage> createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  final MangaDao dao = MangaDao();
  String? selectedTag;
  late Future<List<Manga>> mangasFuture;

  @override
  void initState() {
    super.initState();
    mangasFuture = dao.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(current: MangaPage),
      appBar: AppBar(
        title: const Text('Manga'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          AddButton(
            label: 'Add Manga',
            pageBuilder: (_) => const AddMangaPage(),
            onReturn: () => setState(() {}),
          ),

          const SizedBox(height: 16),

          TagFilterSelector(
            tags: Tags.mangaTags,
            selected: selectedTag,
            onChanged: (tag) {
              setState(() {
                selectedTag = tag;
              });
            },
          ),

          const SizedBox(height: 16),

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'Releasing') ...[
            SectionTitle.text('Weekly Manga'),
            _weekdaySection(),

            const SizedBox(height: 16),

            // Manga cards sections
            SectionTitle.text('Releasing'),
            MangaCardList(
              tagFilter: ['Releasing'],
              onEdited: _reload,
            ),
          ],

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'Reading') ...[
            SectionTitle.text('Reading'),
            MangaCardList(
              tagFilter: ['Reading'],
              onEdited: _reload,
            ),
          ],

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'Paused') ...[
            SectionTitle.text('Paused'),
            MangaCardList(
              tagFilter: ['Paused'],
              onEdited: _reload,
            ),
          ],

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'To Read') ...[
            SectionTitle.text('To Read'),
            MangaCardList(
              tagFilter: ['To Read'],
              onEdited: _reload,
            ),
          ],

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'Hiatus') ...[
            SectionTitle.text('Hiatus'),
            MangaCardList(
              tagFilter: ['Hiatus'],
              onEdited: _reload,
            ),
          ],

          if (selectedTag == null || selectedTag == 'All' || selectedTag == 'Finished') ...[
            SectionTitle.text('Finished'),
            MangaCardList(
              tagFilter: ['Finished'],
              onEdited: _reload,
            ),
          ],

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Current weekly manga section
  Widget _weekdaySection() {
    return ReleasingWeekdaySection<Manga>(
      future: dao.getAll(),
      days: Weekday.weekdaysPlusMonth,
      getWeekday: (m) => m.weekday,
      getTag: (m) => m.tag,
      itemBuilder: (manga, {onEdited}) =>
          MangaCard(manga: manga, onEdited: onEdited),
      onEdited: () => setState(() {}),
    );
  }

  void _reload() {
    setState(() {});
  }
}
