import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/selectors.dart';
import '../ButtonsAndStructures/text_num_fields.dart';
import '../models/pokemon_solo.dart';
import '../DB/pokemon_solo_dao.dart';
import '../theme/styles.dart';
import '../DB/static_values.dart';


class AddPokemonSoloPage extends StatefulWidget {
  final PokemonSolo? pkmnSolo; // null = addPage, not null = editPage

  const AddPokemonSoloPage({super.key, this.pkmnSolo});

  bool get isEdit => pkmnSolo != null;

  @override
  State<AddPokemonSoloPage> createState() => _AddPokemonSoloPageState();
}

class _AddPokemonSoloPageState extends State<AddPokemonSoloPage> {
  final _formKey = GlobalKey<FormState>();

  String? game;
  final pokemonCtrl = TextEditingController();
  final championLevelCtrl = TextEditingController();
  int? championTime;
  final postLevelCtrl = TextEditingController();
  int? postTime;
  Color color = Color(0xFF000000);
  int textColor = Colors.white.value;
  final extraCtrl = TextEditingController();

  int? championHours;
  int? championMinutes;
  int? postHours;
  int? postMinutes;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      final p = widget.pkmnSolo!;

      game = p.game;
      pokemonCtrl.text = p.pokemon;
      championLevelCtrl.text = p.championLevel?.toInt().toString() ?? '';
      _fromMinutes(p.championTime, (h, m) {
        championHours = h;
        championMinutes = m;
      });
      postLevelCtrl.text = p.postLevel?.toInt().toString() ?? '';
      _fromMinutes(p.postTime, (h, m) {
        postHours = h;
        postMinutes = m;
      });
      color = Color(p.color);
      textColor = p.textColor ?? Colors.white.value;
      extraCtrl.text = p.extra ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Run' : 'Add Run'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              selector(
                label: 'Game',
                value: game,
                items: PokemonGame.values,
                required: true,
                onChanged: (v) {
                  setState(() {
                    game = v!;
                  });
                },
              ),

              textField(
                controller: pokemonCtrl,
                label: 'Pokémon',
                required: true,
              ),

              textField(
                controller: championLevelCtrl,
                label: 'Champion Level',
                isNumber: true,
              ),

              TimePickerField(
                label: 'Champion Time',
                hours: championHours,
                minutes: championMinutes,
                onHoursChanged: (v) => championHours = v,
                onMinutesChanged: (v) => championMinutes = v,
              ),

              textField(
                controller: postLevelCtrl,
                label: 'Post Game Level',
                isNumber: true,
              ),

              TimePickerField(
                label: 'Post Game Time',
                hours: postHours,
                minutes: postMinutes,
                onHoursChanged: (v) => postHours = v,
                onMinutesChanged: (v) => postMinutes = v,
              ),

              ColorPickerTile(
                title: 'Pokémon Color',
                color: color,
                onChanged: (c) { setState(() => color = c); },
              ),

              selector(
                label: 'Text Color',
                value: textColor == Colors.white.value ? 'White' : 'Black',
                items: ['Black', 'White'],
                onChanged: (v) {
                  setState(() {
                    textColor = v == 'White' ? Colors.white.value : Colors.black.value;
                  });
                },
              ),

              textField(
                controller: extraCtrl,
                label: 'Extra',
              ),

              const SizedBox(height: 16),
              widget.isEdit
                ? addEditButton(
                  onPressed: () => _submit(id: widget.pkmnSolo!.id, action: PokemonSoloDao().update),
                  buttonStyle: AppButtonStyles.editButtonStyle,
                  text: 'Update')
                : addEditButton(
                  onPressed: () => _submit(id: 0, action: PokemonSoloDao().insert),
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
    required Future<void> Function(PokemonSolo) action,
  }) async {
    if (!_formKey.currentState!.validate()) return;

    final pkmnSolo = PokemonSolo(
      id: id,
      game: game!,
      pokemon: pokemonCtrl.text,
      championLevel: int.tryParse(championLevelCtrl.text),
      championTime: _toMinutes(championHours, championMinutes),
      postLevel: int.tryParse(postLevelCtrl.text),
      postTime: _toMinutes(postHours, postMinutes),
      color: color.value,
      textColor: textColor,
      extra: extraCtrl.text,
    );

    await action(pkmnSolo);
    Navigator.pop(context);

  }

  int? _toMinutes(int? h, int? m) {
    if (h == null && m == null) return null;
    return (h ?? 0) * 60 + (m ?? 0);
  }

  void _fromMinutes(
      int? totalMinutes,
      void Function(int h, int m) onResult,
      ) {
    if (totalMinutes == null) return;
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    onResult(h, m);
  }
}
