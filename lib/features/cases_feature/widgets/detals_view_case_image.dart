import 'package:flutter/material.dart';

class DetalsViewCaseImage extends StatelessWidget {
  const DetalsViewCaseImage({super.key, required this.image});
  final String image ;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        image,
        height: 240,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
