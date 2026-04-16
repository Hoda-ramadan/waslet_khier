import 'package:flutter/material.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/sections_of_charity.dart';

class CategoriesRow extends StatelessWidget {
  final List<CategoryModel> categories;
  final int startIndex;

  const CategoriesRow({
    super.key,
    required this.categories,
    required this.startIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        if (startIndex + index >= categories.length) {
          return const SizedBox();
        }

        return Row(
          children: [
            SectionsOfCharity(categoryModel: categories[startIndex + index]),
            if (index != 2) const SizedBox(width: 20),
          ],
        );
      }),
    );
  }
}
