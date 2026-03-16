import 'package:flutter/material.dart';

// Buttons
class AppButtonStyles {
  // Button text
  static const TextStyle buttonText = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  // Add
  static ButtonStyle addButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF3F51B5),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  // Edit
  static ButtonStyle editButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF315271),
    foregroundColor: Colors.white,
    side: BorderSide(
      color: Colors.white.withOpacity(0.1),
      width: 1,
    ),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  // Delete
  static ButtonStyle deleteButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFB61414),
    foregroundColor: Colors.white,
    side: BorderSide(
      color: Colors.white.withOpacity(0.1),
      width: 1,
    ),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  // Arrow
  static const arrowButtonStyle = ButtonStyle(
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
  );
}

// Cards
class CardStyles {
  // Colors
  static const cardBackground = Color(0xFF3A3A3A);
  static const numBackground   = Color(0xFF2A2A2A);
  static const dividerColor   = Color(0xFF5F6F86);

  // Shape
  static final cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  );

  static const cardMargin = EdgeInsets.symmetric(vertical: 6);
  static const cardPadding = EdgeInsets.all(12);

  // Text
  static const titleText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const epText = TextStyle(
    fontSize: 16,
  );

  // Num container
  static final numBoxDecoration = BoxDecoration(
    color: numBackground,
    borderRadius: BorderRadius.circular(8),
  );
}

// Num/Arrow Divider
class NumDivider extends StatelessWidget {
  const NumDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: CardStyles.dividerColor,
    );
  }
}

// Sections
class SectionStyles {
  static const sectionTitleText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const dividerColor = Color(0xFFBDBDBD);

  static const weekdayText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
}

// Section Divider
class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: SectionStyles.dividerColor,
    );
  }
}





