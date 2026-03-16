import 'package:flutter/material.dart';
import '../Widgets/weekday_section.dart';

class ReleasingWeekdaySection<T> extends StatelessWidget {
  final Future<List<T>> future;
  final List<String> days;

  final String? Function(T item) getWeekday;
  final String Function(T item) getTag;

  final Widget Function(T item, {VoidCallback? onEdited}) itemBuilder;
  final VoidCallback onEdited;

  const ReleasingWeekdaySection({
    super.key,
    required this.future,
    required this.days,
    required this.getWeekday,
    required this.getTag,
    required this.itemBuilder,
    required this.onEdited,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final items = snapshot.data!;

        return WeekdaySection<T>(
          days: days,
          itemsForDay: (day) {
            return items.where((item) {
              final weekday = getWeekday(item);
              return getTag(item) == 'Releasing' &&
                  weekday != null &&
                  weekday == day;
            }).toList();
          },
          itemBuilder: itemBuilder,
          onEdited: onEdited,
        );
      },
    );
  }
}
