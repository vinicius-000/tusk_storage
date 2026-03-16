import 'package:flutter/material.dart';
import '../theme/styles.dart';

Widget textField({
  required TextEditingController controller,
  required String label,
  bool required = false,
  bool isNumber = false,
}) {

  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : null,
      validator: required
          ? (v) => v == null || v.isEmpty ? 'Required' : null
          : null,
      decoration: InputDecoration(labelText: label),
    ),
  );
}

class NumControl extends StatelessWidget {
  final int value;
  final bool canEdit;
  final Future<void> Function(int newValue) onChange;

  const NumControl({
    super.key,
    required this.value,
    required this.canEdit,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (canEdit)
          _arrow(
            icon: Icons.keyboard_arrow_up,
            delta: 1,
          ),

        if (canEdit) const NumDivider(),

        Text(
          value.toString(),
          style: const TextStyle(fontSize: 16),
        ),

        if (canEdit) const NumDivider(),

        if (canEdit)
          _arrow(
            icon: Icons.keyboard_arrow_down,
            delta: -1,
          ),
      ],
    );
  }

  Widget _arrow({
    required IconData icon,
    required int delta,
  }) {
    return IconButton(
      style: AppButtonStyles.arrowButtonStyle,
      icon: Icon(icon),
      onPressed: () async {
        await onChange(value + delta);
      },
    );
  }
}
