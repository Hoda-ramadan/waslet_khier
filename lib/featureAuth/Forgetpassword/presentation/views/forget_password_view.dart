import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/forgetpasswordview_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ForgetPasswordBody(),
      backgroundColor: backGroundColor,
    );
  }
}
