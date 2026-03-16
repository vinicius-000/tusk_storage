import 'package:flutter/material.dart';
import '../ButtonsAndStructures/buttons.dart';
import '../models/pokemon_solo.dart';
import '../DB/pokemon_solo_dao.dart';
import '../Theme/styles.dart';
import '../Pages/add_pokemon_solo_page.dart';
import '../DB/static_values.dart';

// Represents one pkmn run

class PokemonSoloCard extends StatefulWidget {
  final PokemonSolo pkmnSolo;
  final VoidCallback? onEdited;

  const PokemonSoloCard({
    super.key,
    required this.pkmnSolo,
    this.onEdited,
  });

  @override
  State<PokemonSoloCard> createState() => _PokemonSoloCardState();
}

class _PokemonSoloCardState extends State<PokemonSoloCard> {
  bool expanded = false;
  final PokemonSoloDao dao = PokemonSoloDao();

  String? championTimeString;
  String? postTimeString;

  @override
  void initState() {
    super.initState();

    final championFullTime = _toHours(widget.pkmnSolo.championTime);
    final postFullTime = _toHours(widget.pkmnSolo.postTime);

    if (championFullTime != [null, null]) {
      championTimeString = '${championFullTime[0]}h ${championFullTime[1]}m';
    }

    if (postFullTime != [null, null]) {
      postTimeString = '${postFullTime[0]}h ${postFullTime[1]}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(widget.pkmnSolo.color),
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
                    widget.pkmnSolo.pokemon,
                    style: CardStyles.titleText.copyWith
                      (color: Color(widget.pkmnSolo.textColor)),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.pkmnSolo.championLevel != null && widget.pkmnSolo.championLevel != 0) ...[
          Text('Champion Level: ${widget.pkmnSolo.championLevel}',
              style: TextStyle(color: Color(widget.pkmnSolo.textColor))),

          if (widget.pkmnSolo.championTime != null) ...[
            Text('Champion Time: ${championTimeString ?? '-'}',
                style: TextStyle(color: Color(widget.pkmnSolo.textColor))),
          ],

          const SizedBox(height:8),
        ],

        if (widget.pkmnSolo.postLevel != null && widget.pkmnSolo.postLevel != 0) ...[
          Text('Post Game Level: ${widget.pkmnSolo.postLevel}',
            style: TextStyle(color: Color(widget.pkmnSolo.textColor))),

        if (widget.pkmnSolo.postTime != null) ...[
          Text('Post Game Time: ${postTimeString ?? '-'}',
              style: TextStyle(color: Color(widget.pkmnSolo.textColor))),
        ],

          const SizedBox(height:8),
        ],

        if (widget.pkmnSolo.extra != null && widget.pkmnSolo.extra?.isNotEmpty == true) ...[
          Text('Extra: ${widget.pkmnSolo.extra}',
            style: TextStyle(color: Color(widget.pkmnSolo.textColor))),

          const SizedBox(height:8),
        ],

        EditDeleteButtons(
          onEdit: () async {
            await Navigator.push(
              context,
              MaterialPageRoute (
                builder: (_) => AddPokemonSoloPage(pkmnSolo: widget.pkmnSolo),
              ),
            );

            widget.onEdited?.call();
          },

          onDelete: () async {
            await dao.delete(widget.pkmnSolo.id);
            widget.onEdited?.call();
          },

          deleteTitle: 'Delete Run'
        ),
      ],
    );
  }

  List<int?> _toHours(int? t) {
    if (t == null) return [null, null];
    final hours = t ~/ 60;
    final minutes = t % 60;
    return [hours, minutes];
  }
}
