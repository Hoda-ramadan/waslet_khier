import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_model.dart';

class SectionsOfCharity extends StatelessWidget {
  const SectionsOfCharity({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("");
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
              child: Image.network("${categoryModel.iconUrl}"),
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
