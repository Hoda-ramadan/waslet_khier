import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/build_place_holder.dart';

class CharityIcon extends StatelessWidget {
  const CharityIcon({super.key, required this.charityimage});

  final String? charityimage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: tintAppColor.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: tintAppColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: charityimage != null && charityimage!.isNotEmpty
          ? Image.network(
              charityimage!,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const buildPlaceholder(
                isLoading: false,
                hight: 80,
                border: 16,
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const buildPlaceholder(
                  isLoading: true,
                  hight: 80,
                  border: 16,
                );
              },
            )
          : const buildPlaceholder(isLoading: false, hight: 80, border: 16),
    );
  }
}