import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/data/models/ai_cases_model/ai_cases_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/ai_card_donation_image.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class CustomAiCard extends StatelessWidget {
  const CustomAiCard({super.key, required this.aiCasesModel});
  final AiCasesModel aiCasesModel;

  @override
  Widget build(BuildContext context) {
    // حساب نسبة التبرع
    final double progress =
        (aiCasesModel.targetAmount != null &&
            aiCasesModel.collectedAmount != null &&
            aiCasesModel.targetAmount! > 0)
        ? aiCasesModel.collectedAmount! / aiCasesModel.targetAmount!
        : 0.0;

    final int percentage = (progress * 100).round();

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 200,
        width: 450,
        padding: const EdgeInsets.all(4),
        decoration: ShapeDecoration(
          color: const Color(0xFFF9F7FA),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(4, 4),
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
                  // العنوان
                  Text(
                    aiCasesModel.title ?? 'بدون عنوان',
                    style: const TextStyle(
                      color: Color(0xFF040504),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

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
                        style: TextStyle(
                          color: Color(0xFF686B6A),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // الموقع
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        aiCasesModel.location ?? '',
                        style: const TextStyle(
                          color: Color(0xFF686B6A),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.location_on,
                        size: 12,
                        color: Color(0xFF686B6A),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // المبلغ المطلوب والمجموع
                  Text(
                    'المبلغ المطلوب: ${aiCasesModel.targetAmount ?? 0} ج.م',
                    style: const TextStyle(
                      color: Color(0xFF686B6A),
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 2),
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
                          width: 118,
                          height: 118,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 50),
                        )
                      : AiCardDonationImage(width: 118, height: 118),
                ),

                const SizedBox(height: 8),

                DonateNowButtom(width: 118, height: 36, fontSize: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
