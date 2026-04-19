import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class Categoryview extends StatelessWidget {
  const Categoryview({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: backGroundColor,
      body: CategoryView_body(
         
      ),
    );
  }
}

class CategoryView_body extends StatelessWidget {
  const CategoryView_body({super.key, });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
