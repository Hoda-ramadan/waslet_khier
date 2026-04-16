import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_model.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_details_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class CharityDetelsView extends StatelessWidget {
  const CharityDetelsView({
    super.key,
    required this.charity,
    required this.categoryModel,
  });
  final CharityModel charity;
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),

      body: CharityDetailsView_body(
        charity: charity,
        categoryModel: categoryModel,
      ),
    );
  }
}
