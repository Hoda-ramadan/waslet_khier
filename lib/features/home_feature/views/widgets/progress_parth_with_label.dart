import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class ProgressBarWithLabel extends StatelessWidget {
  final double progress; // من 0.0 إلى 1.0

  const ProgressBarWithLabel({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8, bottom: 8),
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            // 🔹 Progress bar
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: tintAppColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
      
            // 🔹 Percentage text (اختياري)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}