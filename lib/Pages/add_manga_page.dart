import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/selectors.dart';
import '../ButtonsAndStructures/text_num_fields.dart';
import '../models/manga.dart';
import '../DB/manga_dao.dart';
import '../theme/styles.dart';
import '../DB/static_values.dart';

class AddMangaPage extends StatefulWidget {
  final Manga? manga; // null = addPage, not null = editPage

  const AddMangaPage({super.key, this.manga});

  bool get isEdit => manga != null;

  @override
  State<AddMangaPage> createState() => _AddMangaPageState();
}

class _AddMangaPageState extends State<AddMangaPage> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final chapCtrl = TextEditingController();
  final typeCtrl = TextEditingController();
  final recapCtrl = TextEditingController();
  final synopsisCtrl = TextEditingController();

  String? weekday;
  String? selectedTag;

  final tags =  Tags.mangaTags;
  final weekdays = Weekday.weekdaysPlusMonth;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      final m = widget.manga!;

      nameCtrl.text = m.name;
      chapCtrl.text = m.chapter?.toInt().toString() ?? '';
      typeCtrl.text = m.type ?? '';
      recapCtrl.text = m.recap ?? '';
      weekday = weekdays.contains(m.weekday) ? m.weekday : null;
      selectedTag = m.tag;
      synopsisCtrl.text = m.synopsis ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Manga' : 'Add Manga'),
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
                label: 'Weekday',
                value: weekday,
                items: weekdays,
                required: false,
                onChanged: (v) => weekday = v,
              ),

              selector(
                label: 'Tag',
                value: selectedTag,
                items: tags,
                required: true,
                onChanged: (v) => selectedTag = v,
              ),

              textField(
                controller: chapCtrl,
                label: 'Chapter',
                isNumber: true,
              ),

              textField(
                controller: typeCtrl,
                label: 'Type',
              ),

              textField(
                controller: recapCtrl,
                label: 'Recap',
              ),

              textField(
                controller: synopsisCtrl,
                label: 'Synopsis',
              ),

              const SizedBox(height: 16),
              widget.isEdit
                ? addEditButton(
                  onPressed: () => _submit(id: widget.manga!.id, action: MangaDao().update),
                  buttonStyle: AppButtonStyles.editButtonStyle,
                  text: 'Update')
                : addEditButton(
                  onPressed: () => _submit(id: 0, action: MangaDao().insert),
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
    required Future<void> Function(Manga) action,
  }) async {
    if (!_formKey.currentState!.validate()) return;

    final manga = Manga(
      id: id,
      name: nameCtrl.text,
      weekday: weekday,
      chapter: double.tryParse(chapCtrl.text),
      tag: selectedTag!,
      type: typeCtrl.text,
      recap: recapCtrl.text,
      synopsis: synopsisCtrl.text,
    );

    await action(manga);
    Navigator.pop(context);

  }
}
