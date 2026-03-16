import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/info_items.dart';
import '../ButtonsAndStructures/text_num_fields.dart';
import '../models/anime.dart';
import '../DB/anime_dao.dart';
import '../Theme/styles.dart';
import '../Pages/add_anime_page.dart';

// Represents one anime
// Shows its name, ep
// Expand and collapse the anime card

class AnimeCard extends StatefulWidget {
  final Anime anime;
  final VoidCallback? onEdited;

  const AnimeCard({
    super.key,
    required this.anime,
    this.onEdited,
  });

  @override
  State<AnimeCard> createState() => _AnimeCardState();
}

class _AnimeCardState extends State<AnimeCard> {
  bool expanded = false;
  late double ep;
  final AnimeDao dao = AnimeDao();

  @override
  void initState() {
    super.initState();
    ep = widget.anime.epNumber ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final canEditEp = widget.anime.tag == 'Releasing' ||
        widget.anime.tag == 'Watching';
    final isFinished = widget.anime.tag == 'Finished';

    return Opacity(
      opacity: isFinished ? 0.55 : 1.0,
      child: Card(
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

              // Left Content (Detail + Collapse Arrow)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    if (!canEditEp) const SizedBox(height: 12),

                    Text(
                      widget.anime.name,
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

              // Right Content (Ep)
              if (!isFinished)
                Container(
                  width: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: CardStyles.numBoxDecoration,
                  child: NumControl(
                      value: ep.toInt(),
                      canEdit: canEditEp,
                      onChange: (newEp) async {
                        setState(() => ep = newEp.toDouble());
                        await dao.updateEpisode(widget.anime.id, ep);
                      }),
                ),
            ],
          ),
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
            InfoItem(label: 'Type', value: widget.anime.type),
            InfoItem(label: 'Synopsis', value: widget.anime.synopsis),
          ],
        ),

        EditDeleteButtons(
          onEdit: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddAnimePage(anime: widget.anime),
              ),
            );

            widget.onEdited?.call();
          },

          onDelete: () async {
            await dao.delete(widget.anime.id);
            widget.onEdited?.call();
          },

          deleteTitle: 'Delete Anime'
        ),
      ],
    );
  }
}