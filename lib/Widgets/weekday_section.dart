import 'package:flutter/material.dart';
import '../theme/styles.dart';


// Generic weekday showing
// Used for animes and mangas

class WeekdaySection<T> extends StatelessWidget {
  final List<String> days;
  final List<T> Function(String day) itemsForDay;
  final Widget Function(T item, {VoidCallback? onEdited}) itemBuilder;
  final VoidCallback? onEdited;

  const WeekdaySection({
    super.key,
    required this.days,
    required this.itemsForDay,
    required this.itemBuilder,
    this.onEdited,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        ...days.map((day) {
          final items = itemsForDay(day);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: SectionStyles.weekdayText,
              ),
              const SizedBox(height: 6),
              Column(
                children: items
                    .map((item) => itemBuilder(item, onEdited: onEdited))
                    .toList(),
              ),
              const SizedBox(height: 12),
            ],
          );
        }).toList(),
      ],
    );
  }
}
