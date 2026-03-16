import 'package:flutter/material.dart';

class Weekday {
  static const List<String> weekdays = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  static const List<String> weekdaysPlusMonth = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'MONTHLY'];
}

class Tags {
  static const List<String> animeTags = ['Releasing', 'Watching', 'Paused', 'To Watch', 'Finished'];
  static const List<String> mangaTags = ['Releasing', 'Reading', 'Paused', 'To Read', 'Hiatus', 'Finished'];
  static const List<String> bookTags = ['To Read', 'Finished'];
}

class PokemonType {
  static const normal   = 'Normal';
  static const fire     = 'Fire';
  static const water    = 'Water';
  static const grass    = 'Grass';
  static const electric = 'Electric';
  static const dark     = 'Dark';
  static const psychic  = 'Psychic';
  static const ghost    = 'Ghost';
  static const bug      = 'Bug';
  static const fighting = 'Fighting';
  static const ground   = 'Ground';
  static const flying   = 'Flying';
  static const rock     = 'Rock';
  static const poison   = 'Poison';
  static const ice      = 'Ice';
  static const dragon   = 'Dragon';
  static const steel    = 'Steel';
  static const fairy    = 'Fairy';

  static const List<String> values = [
    normal, fire, water, grass, electric, dark, psychic, ghost, bug,
    fighting, ground, flying, rock, poison, ice, dragon, steel, fairy,
  ];

  static Color colorCard(String type) {
    switch (type) {
      case fire:     return Color(0xFFE45B00);
      case water:    return Color(0xFF1E88E5);
      case grass:    return Color(0xFF22932A);
      case electric: return Color(0xFFF7D02C);
      case dark:     return Color(0xFF4E3E30);
      case psychic:  return Color(0xFFFF2D95);
      case ghost:    return Color(0xFF735797);
      case bug:      return Color(0xFFA3B623);
      case fighting: return Color(0xFFA51818);
      case ground:   return Color(0xFFD6B453);
      case flying:   return Color(0xFFBCAAF1);
      case rock:     return Color(0xFFB6A136);
      case poison:   return Color(0xFFA33EA1);
      case ice:      return Color(0xFF96D9D6);
      case dragon:   return Color(0xFF6F35FC);
      case steel:    return Color(0xFFB7B7CE);
      case fairy:    return Color(0xFFD685AD);
      default:       return Color(0xFFA8A77A); // Normal
    }
  }

  static Color colorText(String type) {
    const whiteText = {fire, water, grass, dark, psychic,
      ghost, fighting, poison, dragon,
    };

    return whiteText.contains(type)
        ? Colors.white
        : Colors.black;
  }
}

class PokemonGame {
  static const values = [
    'RB', 'Yellow', 'GS', 'Crystal', 'Ruby & Sapphire', 'Emerald', 'FireRed', 'Diamond & Pearl', 'Platinum',
    'HGSS', 'BW', 'BW2', 'XY', 'ORAS', 'Sun & Moon', 'Ultra Sun & Moon',
    'Let’s Go', 'Sword', 'Shield', 'BDSP', 'SV'
  ];

  static TextSpan styled(String game, TextStyle base) {
    switch (game) {
      case 'RB':
        return TextSpan(children: [
          TextSpan(text: 'R', style: _glow(base, const Color(0xFFE53935))),
          TextSpan(text: 'B', style: _glow(base, const Color(0xFF1E88E5))),
        ]);

      case 'Yellow':
        return TextSpan(
          text: 'Yellow', style: _glow(base, const Color(0xFFFFEB3B)),
        );

      case 'GS':
        return TextSpan(children: [
          TextSpan(text: 'G', style: _metallic(base, const Color(0xFFD4AF37))),
          TextSpan(text: 'S', style: _metallic(base, const Color(0xFFB0BEC5))),
        ]);

      case 'Crystal':
        return TextSpan(
            text: 'Crystal', style: _metallic(base, const Color(0xFF64B5F6)),
        );

      case 'Ruby & Sapphire':
        return TextSpan(children: [
          TextSpan(text: 'Ruby ', style: _metallic(base, Colors.red.shade700)),
          TextSpan(text: '& ', style: _glow(base, Colors.white)),
          TextSpan(text: 'Sapphire', style: _metallic(base, Colors.blue.shade700)),
        ]);

      case 'Emerald':
        return TextSpan(
            text: 'Emerald', style: _metallic(base, const Color(0xFF00C853)),
        );

      case 'FireRed':
        return TextSpan(
            text: 'FireRed', style: _glow(base, const Color(0xFFDC1C18)),
        );

      case 'Diamond & Pearl':
        return TextSpan(children: [
          TextSpan(text: 'Diamond ', style: _metallic(base, const Color(0xFF81D4FA))),
          TextSpan(text: '& ', style: _glow(base, Colors.white)),
          TextSpan(text: 'Pearl', style: _metallic(base, const Color(0xFFF48FB1))),
        ]);

      case 'Platinum':
        return TextSpan(
            text: 'Platinum', style: _metallic(base, const Color(0xFFE0E0E0)),
        );

      case 'HGSS':
        return TextSpan(children: [
          TextSpan(text: 'HG', style: _metallic(base, const Color(0xFFD4AF37))),
          TextSpan(text: 'SS', style: _metallic(base, const Color(0xFFB0BEC5))),
        ]);

      case 'BW':
        return TextSpan(children: [
          TextSpan(
            text: 'B',
            style: base.copyWith(
              color: Colors.black,
              shadows: const [
                Shadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 5),
              ],
            ),
          ),
          TextSpan(text: 'W', style: _glow(base, Colors.white)),
        ]);

      case 'BW2':
        return TextSpan(children: [
          TextSpan(
            text: 'B',
            style: base.copyWith(
              color: Colors.black,
              shadows: const [
                Shadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 5),
              ],
            ),
          ),
          TextSpan(text: 'W', style: _glow(base, Colors.white)),
          TextSpan(text: '2', style: _metallic(base, const Color(0xFF2979FF))),
        ]);

      case 'XY':
        return TextSpan(children: [
          TextSpan(text: 'X', style: _glow(base, const Color(0xFF2979FF))),
          TextSpan(text: 'Y', style: _glow(base, const Color(0xFFFF1744))),
        ]);

      case 'ORAS':
        return TextSpan(children: [
          TextSpan(text: 'OR', style: _metallic(base, Colors.red.shade700)),
          TextSpan(text: 'AS', style: _metallic(base, Colors.blue.shade700)),
        ]);

      case 'Sun & Moon':
        return TextSpan(children: [
          TextSpan(text: 'Sun ', style: _glow(base, Colors.orange)),
          TextSpan(text: '& ', style: _glow(base, Colors.white)),
          TextSpan(text: 'Moon', style: _glow(base, Colors.deepPurple)),
        ]);

      case 'Ultra Sun & Moon':
        return TextSpan(children: [
          TextSpan(
            text: 'Ultra ',
            style: base.copyWith(
              color: Colors.black,
              shadows: const [
                Shadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 5),
              ],
            ),
          ),
          TextSpan(text: 'Sun ', style: _glow(base, Colors.orange)),
          TextSpan(text: '& ', style: _glow(base, Colors.white)),
          TextSpan(text: 'Moon', style: _glow(base, Colors.deepPurple)),
        ]);

      case 'Let’s Go':
        return TextSpan(
            text: 'Let’s Go', style: _glow(base, const Color(0xFFFFEB3B)),
        );

      case 'Sword':
        return TextSpan(
            text: 'Sword', style: _glow(base, Colors.blue.shade800),
        );

      case 'Shield':
        return TextSpan(
            text: 'Shield', style: _glow(base, const Color(0xFFFF1744)),
        );

      case 'BDSP':
        return TextSpan(children: [
          TextSpan(text: 'BD', style: _metallic(base, const Color(0xFF81D4FA))),
          TextSpan(text: 'SP', style: _metallic(base, const Color(0xFFF48FB1))),
        ]);

      case 'SV':
        return TextSpan(children: [
          TextSpan(text: 'S', style: _glow(base, const Color(0xFFD32F2F))),
          TextSpan(text: 'V', style: _glow(base, const Color(0xFF7B1FA2))),
        ]);

      default:
        return TextSpan(text: game, style: base);
    }
  }
}

TextStyle _metallic(
    TextStyle base,
    Color color, {
      Color highlight = Colors.white,
    }) {
  return base.copyWith(
    color: color,
    shadows: [
      Shadow(color: highlight.withOpacity(0.8), blurRadius: 2),
      Shadow(color: color.withOpacity(0.6), blurRadius: 1),
    ],
  );
}

TextStyle _glow(
    TextStyle base,
    Color color,
    ) {
  return base.copyWith(
    color: color,
    shadows: [
      Shadow(color: color.withOpacity(0.9), blurRadius: 5),
      Shadow(color: color.withOpacity(0.6), blurRadius: 2),
    ],
  );
}



