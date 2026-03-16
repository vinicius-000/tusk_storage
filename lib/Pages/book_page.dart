import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/titles.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import '../pages/add_book_page.dart';
import '../db/book_dao.dart';
import '../widgets/app_drawer.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final BookDao dao = BookDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(current: BookPage),
      appBar: AppBar(
        title: const Text('Books'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(height: 16),

          AddButton(
            label: 'Add Book',
            pageBuilder: (_) => const AddBookPage(),
            onReturn: () => setState(() {}),
          ),

          const SizedBox(height: 16),

          // Book tags sections
          _bookSections(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bookSections() {
    return FutureBuilder<List<Book>> (
      future: dao.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final books = snapshot.data!;

        // Books w/o type
        final noType = books.where(
            (b) => (b.type == null || b.type!.isEmpty) && b.tag == 'To Read',
        ).toList();

        // Book w/ type
        final withType = books.where(
              (b) => (b.type != null && b.type!.isNotEmpty) && b.tag == 'To Read',
        );

        // Finished books
        final finished = books.where(
              (b) => b.tag == 'Finished',
        );

        // Grouping by tags
        final Map<String, List<Book>> grouped = {};
        for (final book in withType) {
          grouped.putIfAbsent(book.type!, () => []);
          grouped[book.type!]!.add(book);
        }

        return Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // W/o type
            if (noType.isNotEmpty) ...[
              ...noType.map(
                  (b) => BookCard(book: b, onEdited: _reload),
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
                      (b) => BookCard(book: b, onEdited: _reload)
                  ),
                ],
              );
            }),

            // Finished
            if (finished.isNotEmpty) ...[
              SectionTitle.text('Finished'),
              ...finished.map(
                    (b) => BookCard(book: b, onEdited: _reload),
              ),
            ],
          ],
        );
      },
    );
  }

  void _reload() {
    setState(() {});
  }
}
