import 'package:flutter/material.dart';
import '../theme/styles.dart';

class SectionTitle extends StatelessWidget {
  final String? text;
  final InlineSpan? richText;

  const SectionTitle.text(
      String this.text, {
        super.key,
      }) : richText = null;

  const SectionTitle.rich(
      InlineSpan this.richText, {
        super.key,
      }) : text = null;

  @override
  Widget build(BuildContext context) {
    final baseStyle = SectionStyles.sectionTitleText;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (text != null)
            Text(
              text!,
              style: baseStyle,
            )
          else if (richText != null)
            Text.rich(
              richText!,
            ),

          const SectionDivider(),
        ],
      ),
    );
  }
}
