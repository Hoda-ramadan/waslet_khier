import 'package:flutter/material.dart';

class Charity_image extends StatelessWidget {
  const Charity_image({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
         
          ImageFiltered(
            imageFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.85),
              BlendMode.lighten,
            ),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),

          // no stretch
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.network(
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported_outlined,
                  size: 48,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}