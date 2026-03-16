import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/selectors.dart';
import '../ButtonsAndStructures/text_num_fields.dart';
import '../models/book.dart';
import '../DB/book_dao.dart';
import '../theme/styles.dart';
import '../DB/static_values.dart';

class AddBookPage extends StatefulWidget {
  final Book? book; // null = addPage, not null = editPage

  const AddBookPage({super.key, this.book});

  bool get isEdit => book != null;

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  String? tag;
  final typeCtrl = TextEditingController();
  final synopsisCtrl = TextEditingController();

  final tags = Tags.bookTags;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      final b = widget.book!;

      nameCtrl.text = b.name;
      tag = b.tag;
      typeCtrl.text = b.type ?? '';
      synopsisCtrl.text = b.synopsis ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Book' : 'Add Book'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              textField(
                controller: nameCtrl,
                label: 'Name',
                required: true,
              ),

              selector(
                label: 'Tag',
                value: tag,
                items: tags,
                required: true,
                onChanged: (v) {
                  setState(() {
                    tag = v!;
                  });
                },
              ),

              textField(
                controller: typeCtrl,
                label: 'Type',
              ),

              textField(
                controller: synopsisCtrl,
                label: 'Synopsis',
              ),

              const SizedBox(height: 16),
              widget.isEdit
                ? addEditButton(
                  onPressed: () => _submit(id: widget.book!.id, action: BookDao().update),
                  buttonStyle: AppButtonStyles.editButtonStyle,
                  text: 'Update')
                : addEditButton(
                  onPressed: () => _submit(id: 0, action: BookDao().insert),
                  buttonStyle: AppButtonStyles.addButtonStyle,
                  text: 'Save'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit({
    required int id,
    required Future<void> Function(Book) action,
  }) async {
    if (!_formKey.currentState!.validate()) return;

    final book = Book(
      id: id,
      name: nameCtrl.text,
      tag: tag!,
      type: typeCtrl.text,
      synopsis: synopsisCtrl.text,
    );

    await action(book);
    Navigator.pop(context);

  }
}
