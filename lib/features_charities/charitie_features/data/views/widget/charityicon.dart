import 'package:flutter/material.dart';

class charityicon extends StatelessWidget {
  const charityicon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 88,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Image.asset(
        "assets/images/57357.png",
        width: 67,
        height: 67,
        fit: BoxFit.contain,
      ),
    );
  }
}
