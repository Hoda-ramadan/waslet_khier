import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_model.dart';

class SectionsOfCharity extends StatelessWidget {
  const SectionsOfCharity({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  static const Map<String, IconData> categoryIcons = {
    'جراحات': Icons.medical_services_outlined,
    'أدوية وعلاج': Icons.medication_outlined,
    'أجهزة طبية': Icons.monitor_heart_outlined,
    'رعاية كبار السن': Icons.elderly_outlined,
    'تعليم': Icons.school_outlined,
    'تجهيز عرايس': Icons.celebration_outlined,
    'مسكن': Icons.spa_outlined,
    'ملابس': Icons.checkroom_outlined,
  };
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
<<<<<<< HEAD
        context.go("/charities/chaaritedetelies/categoryview");
=======
        context.go("charities/chaaritedetelies/categoryview");
>>>>>>> 83c1e1e14e9e48f41639d772e162b274a1a0759c
      },
      child: Container(
        height: 58,
        width: 104,
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
                categoryIcons[categoryModel.name?.toLowerCase()] ??
                    Icons.category,
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
