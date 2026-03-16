import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/titles.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../pages/add_movie_page.dart';
import '../db/movie_dao.dart';
import '../widgets/app_drawer.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final MovieDao dao = MovieDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(current: MoviePage),
      appBar: AppBar(
        title: const Text('Movies'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(height: 16),

          AddButton(
            label: 'Add Movie',
            pageBuilder: (_) => const AddMoviePage(),
            onReturn: () => setState(() {}),
          ),

          const SizedBox(height: 16),

          // Movie tags sections
          _movieSections(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _movieSections() {
    return FutureBuilder<List<Movie>> (
      future: dao.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final movies = snapshot.data!;

        // Movies w/o type
        final noType = movies.where(
              (b) => b.type == null || b.type!.isEmpty,
        ).toList();

        // Movies w/ type
        final withType = movies.where(
              (b) => b.type != null && b.type!.isNotEmpty,
        );

        // Grouping by tags
        final Map<String, List<Movie>> grouped = {};
        for (final movie in withType) {
          grouped.putIfAbsent(movie.type!, () => []);
          grouped[movie.type!]!.add(movie);
        }

        return Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // W/o type
            if (noType.isNotEmpty) ...[
              ...noType.map(
                    (b) => MovieCard(movie: b, onEdited: _reload),
              ),
            ],

            // W/ Type
            ...grouped.entries.map((entry) {
              final type = entry.key;
              final items = entry.value;

              return Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle.text(type),
                  ...items.map(
                          (b) => MovieCard(movie: b, onEdited: _reload)
                  ),
                ],
              );
            }),
          ],
        );
      },
    );
  }

  void _reload() {
    setState(() {});
  }
}
