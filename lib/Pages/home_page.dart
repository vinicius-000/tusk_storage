import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/home_nav_card.dart';
import '../widgets/app_drawer.dart';
import '../DB/backup.dart';
import '../pages/anime_page.dart';
import '../pages/manga_page.dart';
import '../pages/book_page.dart';
import '../pages/movie_page.dart';
import '../pages/pokemon_monotype_page.dart';
import '../pages/pokemon_solo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(current: HomePage),
      appBar: AppBar(
        title: const Text('Tusk Storage'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [

            // NAVIGATION
            HomeNavCard(
              title: 'Anime',
              icon: Icons.tv,
              color: Colors.redAccent,
              page: const AnimePage(),
            ),
            const SizedBox(height: 12),

            HomeNavCard(
              title: 'Manga',
              icon: Icons.menu_book,
              color: Colors.blueAccent,
              page: const MangaPage(),
            ),
            const SizedBox(height: 12),

            HomeNavCard(
              title: 'Books',
              icon: Icons.book,
              color: Colors.lightBlue.shade100,
              page: const BookPage(),
            ),
            const SizedBox(height: 12),

            HomeNavCard(
              title: 'Movies',
              icon: Icons.movie,
              color: Colors.deepOrangeAccent,
              page: const MoviePage(),
            ),
            const SizedBox(height: 12),

            HomeNavCard(
              title: 'Pokémon Monotype Runs',
              icon: Icons.catching_pokemon,
              color: Colors.greenAccent,
              page: const PokemonMonotypePage(),
            ),
            const SizedBox(height: 12),

            HomeNavCard(
              title: 'Pokémon Solo Runs',
              icon: Icons.bug_report,
              color: Colors.yellow.shade300,
              page: const PokemonSoloPage(),
            ),

            const SizedBox(height: 32),

            // BACKUP SECTION
            const Divider(),

            const SizedBox(height: 12),

            ThemedOutlineButton(
              label: 'Export database',
              icon: Icons.upload,
              onPressed: () async {
                await Backup.exportDb();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Database exported')),
                );
              },
            ),

            const SizedBox(height: 12),

            ThemedOutlineButton(
              label: 'Import database',
              icon: Icons.download,
              onPressed: () async {
                final confirm = await Backup.showImportConfirmDialog(context);
                if (confirm) {
                  final success = await Backup.importDb();
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Database imported')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
