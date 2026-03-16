import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/selectors.dart';
import '../models/pokemon_monotype.dart';
import '../DB/pokemon_monotype_dao.dart';
import '../theme/styles.dart';
import '../DB/static_values.dart';

class AddPokemonMonotypePage extends StatefulWidget {
  final PokemonMonotype? pkmnMono; // null = addPage, not null = editPage

  const AddPokemonMonotypePage({super.key, this.pkmnMono});

  bool get isEdit => pkmnMono != null;

  @override
  State<AddPokemonMonotypePage> createState() => _AddPokemonMonotypePageState();
}

class _AddPokemonMonotypePageState extends State<AddPokemonMonotypePage> {
  final _formKey = GlobalKey<FormState>();

  String? game;
  String? type;
  final TextEditingController _pokemonController = TextEditingController();
  List<String> pokemons = [];

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      final p = widget.pkmnMono!;

      game = p.game;
      type = p.type;
      pokemons = p.pokemon_list
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
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

              selector(
                label: 'Type',
                value: type,
                items: PokemonType.values,
                required: true,
                onChanged: (v) {
                  setState(() {
                    type = v!;
                  });
                },
              ),

              Row(
                children: [
                  Expanded (
                    child: TextFormField(
                      controller: _pokemonController,
                      decoration: const InputDecoration(labelText: 'Pokémon'),
                    ),
                  ),

                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addPokemon,
                  )
                ],
              ),

              if (pokemons.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: pokemons.asMap().entries.map((entry) {
                    final index = entry.key;
                    final name = entry.value;

                    return Chip(
                      label: Text(name),
                      onDeleted: () {
                        setState(() {
                          pokemons.removeAt(index);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 16),
              widget.isEdit
                ? addEditButton(
                  onPressed: () => _submit(id: widget.pkmnMono!.id, action: PokemonMonotypeDao().update),
                  buttonStyle: AppButtonStyles.editButtonStyle,
                  text: 'Update')
                : addEditButton(
                  onPressed: () => _submit(id: 0, action: PokemonMonotypeDao().insert),
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
    required Future<void> Function(PokemonMonotype) action,
  }) async {
    if (!_formKey.currentState!.validate()) return;

    if (pokemons.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one Pokémon')),
      );
      return;
    }

    final pokemonList = pokemons.join(', ');

    final pkmnMono = PokemonMonotype(
      id: id,
      game: game!,
      type: type!,
      pokemon_list: pokemonList,
    );

    await action(pkmnMono);
    Navigator.pop(context);

  }

  void _addPokemon() {
    final name = _pokemonController.text.trim();
    if (name.isEmpty) return;

    setState(() {
      pokemons.add(name);
      _pokemonController.clear();
    });
  }
}
