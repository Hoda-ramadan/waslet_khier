import 'package:flutter/material.dart';

class DetalsViewCaseImage extends StatelessWidget {
  const DetalsViewCaseImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    final bool validUrl =
        image.isNotEmpty && Uri.tryParse(image)?.hasAbsolutePath == true;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: validUrl
          ? Image.network(
              image,
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 240,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 240,
                width: double.infinity,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            )
          : Container(
              height: 240,
              width: double.infinity,
              color: Colors.grey[200],
              child: const Icon(
                Icons.image_not_supported,
                size: 50,
                color: Colors.grey,
              ),
            ),
    );
  }
}
