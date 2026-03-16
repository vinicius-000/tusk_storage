import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/selectors.dart';
import '../ButtonsAndStructures/text_num_fields.dart';
import '../models/anime.dart';
import '../DB/anime_dao.dart';
import '../theme/styles.dart';
import '../DB/static_values.dart';

class AddAnimePage extends StatefulWidget {
  final Anime? anime; // null = addPage, not null = editPage

  const AddAnimePage({super.key, this.anime});

  bool get isEdit => anime != null;

  @override
  State<AddAnimePage> createState() => _AddAnimePageState();
}

class _AddAnimePageState extends State<AddAnimePage> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final epCtrl = TextEditingController();
  final typeCtrl = TextEditingController();
  final synopsisCtrl = TextEditingController();

  String? weekday;
  String? selectedTag;

  final tags = Tags.animeTags;
  final weekdays = Weekday.weekdays;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      final a = widget.anime!;

      nameCtrl.text = a.name;
      epCtrl.text = a.epNumber?.toInt().toString() ?? '';
      typeCtrl.text = a.type ?? '';
      weekday = weekdays.contains(a.weekday) ? a.weekday : null;
      selectedTag = a.tag;
      synopsisCtrl.text = a.synopsis ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isEdit ? 'Edit Anime' : 'Add Anime'),
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
                items: weekdays,
                value: weekday,
                required: false,
                onChanged: (v) => weekday = v,
              ),

              selector(
                label: "Tags",
                items: tags,
                value: selectedTag,
                required: true,
                onChanged: (v) => selectedTag = v,
              ),

              textField(
                controller: epCtrl,
                label: 'Episode',
                isNumber: true,
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
                  onPressed: () => _submit(id: widget.anime!.id, action: AnimeDao().update),
                  buttonStyle: AppButtonStyles.editButtonStyle,
                  text: 'Update')
                : addEditButton(
                  onPressed: () => _submit(id: 0, action: AnimeDao().insert),
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
    required Future<void> Function(Anime) action,
  }) async {
    if (!_formKey.currentState!.validate()) return;

    final anime = Anime(
      id: id,
      name: nameCtrl.text,
      weekday: weekday,
      epNumber: double.tryParse(epCtrl.text),
      tag: selectedTag!,
      type: typeCtrl.text,
      synopsis: synopsisCtrl.text,
    );

    await action(anime);
    Navigator.pop(context);

  }
}
