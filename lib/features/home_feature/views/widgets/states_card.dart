import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/home_feature/data/models/state_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/detals_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class StatesCard extends StatelessWidget {
  const StatesCard({super.key, required this.casee});
  final CaseModel casee;

  @override
  Widget build(BuildContext context) {
    final double target = casee.targetAmount ?? 1;
    final double collected = casee.collectedAmount ?? 0;
    final double safeProgress = (collected / target).clamp(0.0, 1.0);
    final double remaining = (target - collected).clamp(0, double.infinity);
    final int percentage = (safeProgress * 100).toInt();
    return GestureDetector(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: casee.coverImageUrl != null
                  ? Image.network(
                      casee.coverImageUrl!,
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholder(isLoading: false),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return _buildPlaceholder(isLoading: true);
                      },
                    )
                  : _buildPlaceholder(isLoading: true),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Title
                    Text(
                      casee.title!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // 🔹 Description
                    Text(
                      casee.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10),
                    ),

                    const SizedBox(height: 6),

                    // 🔹 Organization
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
                            casee.charityName!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // 🔹 Percentage
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

                    // 🔹 Progress
                    SizedBox(
                      height: 4,
                      child: ProgressBarWithLabel(progress: safeProgress),
                    ),

                    const Spacer(),

                    // 🔹 Buttons
                    Row(
                      children: [
                        Expanded(child: DetalsButtom(height: 30, fontSize: 10)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: DonateNowButtom(height: 30, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder({bool isLoading = false}) {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appcolor.withOpacity(0.15), appcolor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: appcolor,
                  ),
                )
              : Icon(
                  Icons.volunteer_activism, // charity-themed icon
                  size: 36,
                  color: appcolor.withOpacity(0.5),
                ),
          const SizedBox(height: 6),
          Text(
            isLoading ? 'جاري التحميل...' : 'لا توجد صورة',
            style: TextStyle(fontSize: 9, color: appcolor.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
