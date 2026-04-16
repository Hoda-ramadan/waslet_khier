import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/sections_of_charity.dart';

class CustomSections extends StatelessWidget {
  CustomSections({super.key, required this.categoryModel});

  @override
  final CategoryModel categoryModel;
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SectionsOfCharity(categoryModel: categoryModel),
              SizedBox(width: 20),
              SectionsOfCharity(categoryModel: categoryModel),
              SizedBox(width: 20),
              SectionsOfCharity(categoryModel: categoryModel),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SectionsOfCharity(categoryModel: categoryModel),
              SizedBox(width: 20),
              SectionsOfCharity(categoryModel: categoryModel),
              SizedBox(width: 20),
              SectionsOfCharity(categoryModel: categoryModel),
            ],
          ),
        ],
      ),
    );
  }
}
