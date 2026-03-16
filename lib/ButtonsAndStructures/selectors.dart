import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Widget selector({
  required String label,
  required List<String> items,
  String? value,
  bool required = false,
  required void Function(String?) onChanged,
}) {

  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(
        value: e,
        child: Text(e),
      ))
          .toList(),
      onChanged: onChanged,
      validator: required
          ? (v) =>  v == null || v.isEmpty ? 'Required' : null
          : null,
      decoration: InputDecoration(labelText: label),
    ),
  );
}

class ColorPickerTile extends StatelessWidget {
  final String title;
  final Color color;
  final ValueChanged<Color> onChanged;

  const ColorPickerTile({
    super.key,
    required this.title,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        trailing: CircleAvatar(
          backgroundColor: color,
        ),
        onTap: () async {
          Color tempColor = color;

          final selected = await showDialog<Color>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Pick a color'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: tempColor,
                  onColorChanged: (c) => tempColor = c,
                  enableAlpha: false,
                  labelTypes: const [],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, tempColor),
                  child: const Text('Select'),
                ),
              ],
            ),
          );

          if (selected != null) {
            onChanged(selected);
          }
        },
      ),
    );
  }
}

class TimePickerField extends StatelessWidget {
  final String label;
  final int? hours;
  final int? minutes;
  final ValueChanged<int?> onHoursChanged;
  final ValueChanged<int?> onMinutesChanged;

  const TimePickerField({
    super.key,
    required this.label,
    required this.hours,
    required this.minutes,
    required this.onHoursChanged,
    required this.onMinutesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: hours?.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Hours'),
                  onChanged: (v) => onHoursChanged(int.tryParse(v)),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: TextFormField(
                  initialValue: minutes?.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Minutes'),
                  onChanged: (v) => onMinutesChanged(int.tryParse(v)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
