import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/changepassword_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class ChangepasswordView extends StatelessWidget {
  const ChangepasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ChangepasswordBody(),
      backgroundColor: backGroundColor,
    );
  }
}
