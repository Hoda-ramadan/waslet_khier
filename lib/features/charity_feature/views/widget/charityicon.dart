import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/build_place_holder.dart';

class CharityIcon extends StatelessWidget {
  const CharityIcon({super.key, required this.charityimage});

  final String? charityimage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(15),
      child: Container(
        width: 84,
        height: 88,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: tintAppColor),
        ),
        child: charityimage != null && charityimage!.isNotEmpty
            ? Expanded(
                child: Image.network(
                  charityimage!,
                  height: 67,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,

                  errorBuilder: (context, error, stackTrace) =>
                      const buildPlaceholder(
                        isLoading: false,
                        hight: 67,
                        border: 20,
                      ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const buildPlaceholder(
                      isLoading: true,
                      hight: 67,
                      border: 20,
                    );
                  },
                ),
              )
            : const buildPlaceholder(isLoading: false, hight: 67, border: 20),
      ),
    );
  }
}
