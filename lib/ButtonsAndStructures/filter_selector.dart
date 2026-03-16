import 'package:flutter/material.dart';

class TagFilterSelector extends StatelessWidget {
  final List<String> tags;
  final String? selected;
  final ValueChanged<String?> onChanged;

  const TagFilterSelector({
    super.key,
    required this.tags,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = ['All', ...tags];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: selected ?? 'All',
        decoration: const InputDecoration(labelText: 'Filter by Tag'),
        items: items
            .map((t) => DropdownMenuItem(
          value: t,
          child: Text(t),
        ))
            .toList(),
        onChanged: (value) {
          if (value == 'All') {
            onChanged(null);
          } else {
            onChanged(value);
          }
        },
      ),
    );
  }
}