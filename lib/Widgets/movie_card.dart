import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/info_items.dart';
import '../models/movie.dart';
import '../DB/movie_dao.dart';
import '../Theme/styles.dart';
import '../Pages/add_movie_page.dart';

// Represents one movie

class MovieCard extends StatefulWidget {
  final Movie movie;
  final VoidCallback? onEdited;

  const MovieCard({
    super.key,
    required this.movie,
    this.onEdited,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool expanded = false;
  final MovieDao dao = MovieDao();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CardStyles.cardBackground,
      elevation: 2,
      shape: CardStyles.cardShape,
      margin: CardStyles.cardMargin,

      child: Padding(
        padding: CardStyles.cardPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 12),

                  Text(
                    widget.movie.name,
                    style: CardStyles.titleText,
                  ),

                  if (expanded) ...[
                    const SizedBox(height: 6),
                    _expandedContent(),
                  ],

                  const SizedBox(height: 4),

                  // Expand Arrow
                  ExpandToggleButton(
                    expanded: expanded,
                    onToggle: () => setState(() => expanded = !expanded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoItems(
          items: [
            InfoItem(label: 'Synopsis', value: widget.movie.synopsis),
          ],
        ),

        EditDeleteButtons(
          onEdit: () async {
            await Navigator.push(
              context,
              MaterialPageRoute (
                builder: (_) => AddMoviePage(movie: widget.movie),
              ),
            );

            widget.onEdited?.call();
          },

          onDelete: () async {
            await dao.delete(widget.movie.id);
            widget.onEdited?.call();
          },

          deleteTitle: 'Delete Movie'
        ),
      ],
    );
  }
}
