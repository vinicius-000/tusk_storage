import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/info_items.dart';
import '../ButtonsAndStructures/text_num_fields.dart';
import '../models/manga.dart';
import '../DB/manga_dao.dart';
import '../Theme/styles.dart';
import '../Pages/add_manga_page.dart';

// Represents one manga
// Shows its name, chapter
// Expand and collapse the manga card

class MangaCard extends StatefulWidget {
  final Manga manga;
  final VoidCallback? onEdited;

  const MangaCard({
    super.key,
    required this.manga,
    this.onEdited,
  });

  @override
  State<MangaCard> createState() => _MangaCardState();
}

class _MangaCardState extends State<MangaCard> {
  bool expanded = false;
  late double chap;
  final MangaDao dao = MangaDao();

  @override
  void initState() {
    super.initState();
    chap = widget.manga.chapter ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final canEditChap = widget.manga.tag == 'Releasing' || widget.manga.tag == 'Reading';
    final isFinished = widget.manga.tag == 'Finished';

    return Opacity (
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

                    if (!canEditChap) const SizedBox(height: 12),

                    Text(
                      widget.manga.name,
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

              // Right Content (Chapter)
              if (!isFinished)
                Container(
                  width: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: CardStyles.numBoxDecoration,
                  child: NumControl(
                    value: chap.toInt(),
                    canEdit: canEditChap,
                    onChange: (newChap) async {
                      setState(() => chap = newChap.toDouble());
                      await dao.updateChapter(widget.manga.id, chap);
                    },
                  ),
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
            InfoItem(label: 'Type', value: widget.manga.type),
            InfoItem(label: 'Recap', value: widget.manga.recap),
            InfoItem(label: 'Synopsis', value: widget.manga.synopsis),
          ],
        ),

        EditDeleteButtons(
          onEdit: () async {
            await Navigator.push(
              context,
              MaterialPageRoute (
                builder: (_) => AddMangaPage(manga: widget.manga),
              ),
            );

            widget.onEdited?.call();
          },

          onDelete: () async {
            await dao.delete(widget.manga.id);
            widget.onEdited?.call();
          },

          deleteTitle: 'Delete Manga'
        ),
      ],
    );
  }
}
