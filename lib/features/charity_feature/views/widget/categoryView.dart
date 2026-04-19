import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/categoryviewbody.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class Categoryview extends StatelessWidget {
  const Categoryview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: backGroundColor,
      body: CategoryView_body(),
    );
  }
}
