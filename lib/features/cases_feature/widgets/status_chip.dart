import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;

  const StatusChip({
    required this.title,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(title, style: TextStyle(color: textColor, fontSize: 12)),
    );
  }
}
