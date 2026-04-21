import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/build_place_holder.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/detals_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class StatesCard extends StatelessWidget {
  const StatesCard({super.key, required this.casee});

  final CaseModel casee;

  @override
  Widget build(BuildContext context) {
    final double target = (casee.targetAmount ?? 1).toDouble();
    final double collected = (casee.collectedAmount ?? 0).toDouble();

    final double progress = target == 0
        ? 0
        : (collected / target).clamp(0.0, 1.0);

    final double remaining = (target - collected).clamp(0, double.infinity);
    final int percentage = (progress * 100).toInt();

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
        children: [
          // 🔹 Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: casee.coverImageUrl != null
                ? Image.network(
                    casee.coverImageUrl!,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => buildPlaceholder(
                      isLoading: false,
                      hight: 110,
                      border: 0,
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return buildPlaceholder(
                        isLoading: true,
                        hight: 110,
                        border: 0,
                      );
                    },
                  )
                : buildPlaceholder(isLoading: true, hight: 110, border: 0),
          ),

          // 🔹 Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // 🔥 حل overflow
                children: [
                  // 🔹 Title + Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        casee.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        casee.description ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),

                  // 🔹 Charity
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/bx_buildings.png',
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          casee.charityName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),

                  // 🔹 Progress Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("$percentage%"),
                          const Text(
                            "المبلغ المتبقي",
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                      Text(
                        "${remaining.toStringAsFixed(0)} ج.م",
                        style: TextStyle(color: appcolor, fontSize: 10),
                      ),
                      const SizedBox(height: 4),

                      // 🔥 Progress
                      ProgressBarWithLabel(progress: progress),
                    ],
                  ),

                  // 🔹 Buttons
                  Row(
                    children: [
                      Expanded(child: DetalsButtom(height: 30, fontSize: 10)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: DonateNowButtom(
                          height: 30,
                          fontSize: 10,
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
