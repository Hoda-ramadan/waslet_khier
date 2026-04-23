import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/aboutApp_body.dart';

class AboutappView extends StatelessWidget {
  const AboutappView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),
      body: AboutAppBody(),
    );
  }
}
