import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';

class SectionsOfCharity extends StatelessWidget {
  const SectionsOfCharity({super.key, required this.categoryModel});
  final CategoryMadel categoryModel;
  static const Map<String, IconData> categoryIcons = {
    'جراحات': Icons.medical_services_outlined,
    'أدوية وعلاج': Icons.medication_outlined,
    'أجهزة طبية': Icons.monitor_heart_outlined,
    'رعاية كبار السن': Icons.elderly_outlined,
    'تعليم': Icons.school_outlined,
    'تجهيز عرايس': Icons.celebration_outlined,
    'مسكن': Icons.spa_outlined,
    'ملابس': Icons.checkroom_outlined,
    'كفالة أيتام': Icons.volunteer_activism_outlined,
    'صحة': Icons.health_and_safety_outlined,
  };
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          "/charities/chaaritedetelies/Category/${categoryModel.id}",
          extra: categoryModel,
        );
      },
      child: Container(
        height: 58,
        width: (MediaQuery.of(context).size.width - 80) / 3,
        decoration: BoxDecoration(
          border: Border.all(color: tintAppColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 40,
              child: Icon(
                categoryIcons[categoryModel.name] ?? Icons.category,
                size: 28,
                color: tintAppColor,
              ),
            ),
            Text(
              "${categoryModel.name}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
