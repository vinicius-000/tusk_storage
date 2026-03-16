import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/info_items.dart';
import '../models/book.dart';
import '../DB/book_dao.dart';
import '../Theme/styles.dart';
import '../Pages/add_book_page.dart';

// Represents one book

class BookCard extends StatefulWidget {
  final Book book;
  final VoidCallback? onEdited;

  const BookCard({
    super.key,
    required this.book,
    this.onEdited,
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool expanded = false;
  final BookDao dao = BookDao();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isFinished = widget.book.tag == 'Finished';

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

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 12),

                    Text(
                      widget.book.name,
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
      )
    );
  }

  Widget _expandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoItems(
          items: [
            InfoItem(label: 'Synopsis', value: widget.book.synopsis),
          ],
        ),

        EditDeleteButtons(
          onEdit: () async {
            await Navigator.push(
              context,
              MaterialPageRoute (
                builder: (_) => AddBookPage(book: widget.book),
              ),
            );

            widget.onEdited?.call();
          },

          onDelete: () async {
            await dao.delete(widget.book.id);
            widget.onEdited?.call();
          },

          deleteTitle: 'Delete Book'
        ),
      ],
    );
  }
}
