import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/splash_feature/widgets/customindecator.dart';
import 'package:waslet_khier/features/splash_feature/widgets/spalshviewbody3.dart';
import 'package:waslet_khier/features/splash_feature/widgets/splash_view2.dart';
import 'package:waslet_khier/features/splash_feature/widgets/splashview3.dart';
import 'package:waslet_khier/features/splash_feature/widgets/splashview4.dart';

class SplashView3 extends StatelessWidget {
  const SplashView3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Splash_View3_body(),
      backgroundColor: backGroundColor,
    );
  }
}
