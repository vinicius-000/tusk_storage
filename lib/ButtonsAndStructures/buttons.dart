import 'package:flutter/material.dart';
import '../theme/styles.dart';

Widget addEditButton({
  required VoidCallback onPressed,
  required ButtonStyle buttonStyle,
  required String text,
}) {
  return ElevatedButton(
    style: buttonStyle,
    onPressed: onPressed,
    child: Text(text, style: AppButtonStyles.buttonText),
  );
}

class EditDeleteButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;
  final String deleteTitle;

  const EditDeleteButtons({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.deleteTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: ElevatedButton.icon(
            style: AppButtonStyles.editButtonStyle,
            icon: const Icon(Icons.edit, size: 18),
            label: const Text(
              'Edit',
              style: AppButtonStyles.buttonText,
            ),
            onPressed: onEdit,
          ),
        ),

        const SizedBox(width: 8),

        ElevatedButton.icon(
          style: AppButtonStyles.deleteButtonStyle,
          icon: const Icon(Icons.delete, size: 18),
          label: const Text(
            'Delete',
            style: AppButtonStyles.buttonText,
          ),
          onPressed: () => _confirmDelete(context),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(deleteTitle),
        content: Text('Are you sure?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFB61414)),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await onDelete();
    }
  }
}

class AddButton extends StatelessWidget {
  final String label;
  final WidgetBuilder pageBuilder;
  final VoidCallback? onReturn;

  const AddButton({
    super.key,
    required this.label,
    required this.pageBuilder,
    this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: AppButtonStyles.addButtonStyle,
      icon: const Icon(Icons.add),
      label: Text(label, style: AppButtonStyles.buttonText),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: pageBuilder),
        );

        onReturn?.call();
      },
    );
  }
}

class ExpandToggleButton extends StatelessWidget {
  final bool expanded;
  final VoidCallback onToggle;

  const ExpandToggleButton({
    super.key,
    required this.expanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      icon: Icon(
        expanded ? Icons.expand_less : Icons.expand_more,
      ),
      onPressed: onToggle,
    );
  }
}

class ThemedOutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const ThemedOutlineButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return OutlinedButton.icon(
      icon: Icon(icon, color: primary),
      label: Text(
        label,
        style: TextStyle(color: primary),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

