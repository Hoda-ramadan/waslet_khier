import 'package:flutter/material.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/ai_card_donation_image.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class CustomAiCard extends StatelessWidget {
  const CustomAiCard({super.key, required this.aiCasesModel});
  final aiCasesModel;

  @override
  Widget build(BuildContext context) {
    final double progress =
        (aiCasesModel.targetAmount != null &&
            aiCasesModel.collectedAmount != null &&
            aiCasesModel.targetAmount! > 0)
        ? aiCasesModel.collectedAmount! / aiCasesModel.targetAmount!
        : 0.0;

    final int percentage = (progress * 100).round();

    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width * 0.80,
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: const Color(0xFFF9F7FA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العمود الأيسر - البيانات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 4),

                // الوصف
                Text(
                  aiCasesModel.description ?? '',
                  style: const TextStyle(
                    color: Color(0xFF686B6A),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),

                // الجمعية
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      aiCasesModel.charityName ?? '',
                      style: const TextStyle(
                        color: Color(0xFF686B6A),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      ':الجمعية',
                      style: TextStyle(color: Color(0xFF686B6A), fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // الموقع
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: Color(0xFF686B6A),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // المبلغ المطلوب
                Text(
                  'المبلغ المطلوب: ${aiCasesModel.targetAmount ?? 0} ج.م',
                  style: const TextStyle(
                    color: Color(0xFF686B6A),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 2),

                // تم جمع
                Text(
                  'تم جمع: ${aiCasesModel.collectedAmount ?? 0} ج.م',
                  style: const TextStyle(
                    color: Color(0xFF3DAB7A),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                // نسبة التقدم
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        color: Color(0xFF686B6A),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(child: ProgressBarWithLabel(progress: progress)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // العمود الأيمن - الصورة والزر
          Column(
            children: [
              // صورة الحالة
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: aiCasesModel.coverImageUrl != null
                    ? Image.network(
                        '${aiCasesModel.coverImageUrl}',
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 50),
                      )
                    : AiCardDonationImage(width: 110, height: 110),
              ),

              const SizedBox(height: 6),

              DonateNowButtom(
                width: 110,
                height: 34,
                fontSize: 14,
                caseModel: aiCasesModel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
