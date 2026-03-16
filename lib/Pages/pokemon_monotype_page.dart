import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/titles.dart';
import '../models/pokemon_monotype.dart';
import '../widgets/pokemon_monotype_card.dart';
import '../pages/add_pokemon_monotype_page.dart';
import '../db/pokemon_monotype_dao.dart';
import '../widgets/app_drawer.dart';
import '../theme/styles.dart';
import '../DB/static_values.dart';

class PokemonMonotypePage extends StatefulWidget {
  const PokemonMonotypePage({super.key});

  @override
  State<PokemonMonotypePage> createState() => _PokemonMonotypePageState();
}

class _PokemonMonotypePageState extends State<PokemonMonotypePage> {
  final PokemonMonotypeDao dao = PokemonMonotypeDao();

  String? selectedGame;
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(current: PokemonMonotypePage),
      appBar: AppBar(
        title: const Text('Pokémon Monotype Runs'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(height: 16),

          AddButton(
            label: 'Add Run',
            pageBuilder: (_) => const AddPokemonMonotypePage(),
            onReturn: () => setState(() {}),
          ),

          const SizedBox(height: 16),

          _filterButton(
            hint: 'Filter by game',
            all: 'All games',
            items: PokemonGame.values,
            value: selectedGame,
            onChanged: (v) {
              setState(() {
                selectedGame = v;
              });
            },
          ),

          const SizedBox(height: 16),

          _filterButton(
            hint: 'Filter by type',
            all: 'All types',
            items: PokemonType.values,
            value: selectedType,
            onChanged: (v) {
              setState(() {
                selectedType = v;
              });
            },
          ),

          const SizedBox(height: 16),

          // Section by games
          _gamesSections(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // 'Filter' button
  Widget _filterButton({
    required String hint,
    required String all,
    required List<String> items,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String> (
      value: value,
      hint: Text(hint),
      items: [
        DropdownMenuItem<String> (
          value: null,
          child: Text(all),
        ),
        ...items.map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
        ),
      ],
      onChanged: onChanged,
      decoration: InputDecoration(prefixIcon: Icon(Icons.filter_list)),
    );
  }

  Widget _gamesSections() {
    return FutureBuilder<List<PokemonMonotype>> (
      future: dao.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final runs = snapshot.data!;

        final filteredRuns = runs.where((r) {
          final matchGame =
              selectedGame == null || r.game == selectedGame;

          final matchType =
              selectedType == null || r.type == selectedType;

          return matchGame && matchType;
        }).toList();

        final Map<String, List<PokemonMonotype>> groupedRuns = {};

        for (final run in filteredRuns) {
          groupedRuns.putIfAbsent(run.game, () => []);
          groupedRuns[run.game]!.add(run);
        }

        return Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...groupedRuns.entries.map((entry) {
              final game = entry.key;
              final items = entry.value;

              return Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle.rich(PokemonGame.styled(game, SectionStyles.sectionTitleText),),
                  ...items.map(
                          (p) => PokemonMonotypeCard(pkmnMono: p, onEdited: _reload)
                  ),
                ],
              );
            }),
          ],
        );
      },
    );
  }

  void _reload() {
    setState(() {});
  }
}
