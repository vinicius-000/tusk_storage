import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/anime_page.dart';
import '../pages/manga_page.dart';
import '../pages/book_page.dart';
import '../pages/movie_page.dart';
import '../pages/pokemon_monotype_page.dart';
import '../pages/pokemon_solo_page.dart';


class AppDrawer extends StatelessWidget {
  final Type current;

  const AppDrawer({
    super.key,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 260,
      elevation: 0,
      backgroundColor: Colors.transparent,

      child: SafeArea(
        child: Container(
          color: const Color(0xFF1E1E1E),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Container(
                height: kToolbarHeight,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                color: Colors.black,
                child: const Text(
                  'Section',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _item(context, 'Home', const HomePage(), HomePage),
                    _item(context, 'Anime', const AnimePage(), AnimePage),
                    _item(context, 'Manga', const MangaPage(), MangaPage),
                    _item(context, 'Books', const BookPage(), BookPage),
                    _item(context, 'Movies', const MoviePage(), MoviePage),
                    _item(context, 'Pokémon Monotype Runs', const PokemonMonotypePage(), PokemonMonotypePage),
                    _item(context, 'Pokémon Solo Runs', const PokemonSoloPage(), PokemonSoloPage),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(BuildContext context, String title, Widget page, Type pageType) {
    final isActive = current == pageType;

    return Container (
      color: isActive?  Colors.white.withOpacity(0.08) : Colors.transparent,
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? Colors.white : Colors.white70,
          ),
        ),

        onTap: () {
          Navigator.pop(context);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}
