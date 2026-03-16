import 'package:flutter/material.dart';

class InfoItem {
  final String label;
  final String? value;

  const InfoItem({
    required this.label,
    required this.value,
  });

  bool get isVisible => value?.isNotEmpty == true;
}

class InfoItems extends StatelessWidget {
  final List<InfoItem> items;

  const InfoItems({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final visibleItems = items.where((i) => i.isVisible).toList();

    if (visibleItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in visibleItems) ...[
          Text('${item.label}: ${item.value}'),
          const SizedBox(height: 2),
        ],

        const SizedBox(height: 8),
      ],
    );
  }
}
