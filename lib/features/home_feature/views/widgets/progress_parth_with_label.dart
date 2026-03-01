import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class ProgressBarWithLabel extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const ProgressBarWithLabel({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: Colors.grey.shade300, 
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
       
          FractionallySizedBox(
            widthFactor: progress, 
            child: Container(
              decoration: BoxDecoration(
                color: tintAppColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          /*
          // Percentage text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4), // text padding
            child: Align(
              alignment: Alignment.centerLeft, // text aligned left
              child: Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black, // text color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          */
        ],
      ),
    );
  }
}