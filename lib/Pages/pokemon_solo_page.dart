import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../ButtonsAndStructures/titles.dart';
import '../models/pokemon_solo.dart';
import '../widgets/pokemon_solo_card.dart';
import '../pages/add_pokemon_solo_page.dart';
import '../db/pokemon_solo_dao.dart';
import '../widgets/app_drawer.dart';
import '../theme/styles.dart';
import '../DB/static_values.dart';

class PokemonSoloPage extends StatefulWidget {
  const PokemonSoloPage({super.key});

  @override
  State<PokemonSoloPage> createState() => _PokemonSoloPageState();
}

class _PokemonSoloPageState extends State<PokemonSoloPage> {
  final PokemonSoloDao dao = PokemonSoloDao();

  String? selectedGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(current: PokemonSoloPage),
      appBar: AppBar(
        title: const Text('Pokémon Solo Runs'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(height: 16),

          AddButton(
            label: 'Add Run',
            pageBuilder: (_) => const AddPokemonSoloPage(),
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
    return FutureBuilder<List<PokemonSolo>> (
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
          final matchGame = selectedGame == null || r.game == selectedGame;
          return matchGame;
        }).toList();

        final Map<String, List<PokemonSolo>> groupedRuns = {};

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
                          (p) => PokemonSoloCard(pkmnSolo: p, onEdited: _reload)
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
