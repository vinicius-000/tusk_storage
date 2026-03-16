import 'package:flutter/material.dart';

class HomeNavCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget page;

  const HomeNavCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color.withOpacity(0.4),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
