import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/splash_feature/widgets/customindecator.dart';
import 'package:waslet_khier/features/splash_feature/widgets/splashview3.dart';
import 'package:waslet_khier/features/splash_feature/widgets/splashview_body2.dart';

class SplashView2 extends StatelessWidget {
  const SplashView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Splash_View_body(),
      backgroundColor: backGroundColor,
    );
  }
}
