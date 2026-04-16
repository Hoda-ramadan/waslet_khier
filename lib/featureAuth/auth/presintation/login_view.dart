import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/loginView_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: backGroundColor,
      body: LoginviewBody(),
    );
  }
}
