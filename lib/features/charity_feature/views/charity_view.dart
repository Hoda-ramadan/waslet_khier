import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/widget/CustomAppbar.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_page_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class CharityView extends StatelessWidget {
  const CharityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CharityPageBody(),
      backgroundColor: backGroundColor,
    );
  }
}
