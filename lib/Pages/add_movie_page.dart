import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/text_num_fields.dart';
import '../models/movie.dart';
import '../DB/movie_dao.dart';
import '../theme/styles.dart';

class AddMoviePage extends StatefulWidget {
  final Movie? movie; // null = addPage, not null = editPage

  const AddMoviePage({super.key, this.movie});

  bool get isEdit => movie != null;

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final typeCtrl = TextEditingController();
  final synopsisCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      final m = widget.movie!;

      nameCtrl.text = m.name;
      typeCtrl.text = m.type ?? '';
      synopsisCtrl.text = m.synopsis ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Movie' : 'Add Movie'),
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
                  onPressed: () => _submit(id: widget.movie!.id, action: MovieDao().update),
                  buttonStyle: AppButtonStyles.editButtonStyle,
                  text: 'Update')
                : addEditButton(
                  onPressed: () => _submit(id: 0, action: MovieDao().insert),
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
    required Future<void> Function(Movie) action,
  }) async {
    if (!_formKey.currentState!.validate()) return;

    final movie = Movie(
      id: id,
      name: nameCtrl.text,
      type: typeCtrl.text,
      synopsis: synopsisCtrl.text,
    );

    await action(movie);
    Navigator.pop(context);

  }
}
