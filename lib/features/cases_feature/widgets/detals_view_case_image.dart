import 'package:flutter/material.dart';

class DetalsViewCaseImage extends StatelessWidget {
  const DetalsViewCaseImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        "assets/images/patiant.png",
        height: 240,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

