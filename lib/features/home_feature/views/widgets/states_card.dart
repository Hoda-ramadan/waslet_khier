import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/build_place_holder.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/detals_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class StatesCard extends StatelessWidget {
  const StatesCard({
    super.key,
    required this.casee,
    this.cardWidth,
    this.maxDescLines = 2, // ← default 2 for grid view
  });

  final CaseModel casee;
  final double? cardWidth;
  final int maxDescLines;

  @override
  Widget build(BuildContext context) {
    final double target = (casee.targetAmount ?? 1).toDouble();
    final double collected = (casee.collectedAmount ?? 0).toDouble();
    final double progress =
        target == 0 ? 0 : (collected / target).clamp(0.0, 1.0);
    final double remaining = (target - collected).clamp(0, double.infinity);
    final int percentage = (progress * 100).toInt();

    final double resolvedWidth =
        cardWidth ?? (MediaQuery.of(context).size.width - 12 * 3) / 2;
    final double imageHeight = resolvedWidth * 0.55;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: casee.coverImageUrl != null
                ? Image.network(
                    casee.coverImageUrl!,
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => buildPlaceholder(
                      isLoading: false,
                      hight: imageHeight,
                      border: 0,
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return buildPlaceholder(
                        isLoading: true,
                        hight: imageHeight,
                        border: 0,
                      );
                    },
                  )
                : buildPlaceholder(
                    isLoading: false, hight: imageHeight, border: 0),
          ),

          // 🔹 Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // 🔹 Title
                  Text(
                    casee.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 2),

                  // 🔹 Description
                  Text(
                    casee.description ?? "",
                    maxLines: maxDescLines, // ← controlled by parameter
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 2),

                  // 🔹 Charity
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/bx_buildings.png',
                        width: 12,
                        height: 12,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          casee.charityName ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 9),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  // 🔹 Progress Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$percentage%",
                        style: const TextStyle(fontSize: 9),
                      ),
                      Text(
                        "${remaining.toStringAsFixed(0)} ج.م",
                        style: TextStyle(color: appcolor, fontSize: 9),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  ProgressBarWithLabel(progress: progress),

                  const SizedBox(height: 4),

                  // 🔹 Buttons
                  Row(
                    children: [
                      Expanded(child: DetalsButtom(height: 26, fontSize: 9)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: DonateNowButtom(
                          height: 26,
                          fontSize: 9,
                          caseModel: casee,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}