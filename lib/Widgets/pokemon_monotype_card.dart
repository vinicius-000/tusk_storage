import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../models/pokemon_monotype.dart';
import '../DB/pokemon_monotype_dao.dart';
import '../Theme/styles.dart';
import '../Pages/add_pokemon_monotype_page.dart';
import '../DB/static_values.dart';

// Represents one pkmn run

class PokemonMonotypeCard extends StatefulWidget {
  final PokemonMonotype pkmnMono;
  final VoidCallback? onEdited;

  const PokemonMonotypeCard({
    super.key,
    required this.pkmnMono,
    this.onEdited,
  });

  @override
  State<PokemonMonotypeCard> createState() => _PokemonMonotypeCardState();
}

class _PokemonMonotypeCardState extends State<PokemonMonotypeCard> {
  bool expanded = false;
  final PokemonMonotypeDao dao = PokemonMonotypeDao();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: PokemonType.colorCard(widget.pkmnMono.type),
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
                    widget.pkmnMono.type,
                    style: CardStyles.titleText.copyWith
                      (color: PokemonType.colorText(widget.pkmnMono.type)),
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
    );
  }

  Widget _expandedContent() {
    final pokemons = widget.pkmnMono.pokemon_list
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pokémons: ',
            style: TextStyle(fontWeight: FontWeight.bold,
                color:PokemonType.colorCard(widget.pkmnMono.type))),

        const SizedBox(height: 2),

        ...pokemons.map(
            (p) => Padding(
              padding: const EdgeInsets.only(left: 16, top: 2),
              child: Text(p, style: TextStyle(color: PokemonType.colorText(widget.pkmnMono.type))),
            ),
        ),

        const SizedBox(height:8),

        EditDeleteButtons(
          onEdit: () async {
            await Navigator.push(
              context,
              MaterialPageRoute (
                builder: (_) => AddPokemonMonotypePage(pkmnMono: widget.pkmnMono),
              ),
            );

            widget.onEdited?.call();
          },

          onDelete: () async {
            await dao.delete(widget.pkmnMono.id);
            widget.onEdited?.call();
          },

          deleteTitle: 'Delete Run'
        ),
      ],
    );
  }
}
