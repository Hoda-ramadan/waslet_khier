import 'package:flutter/material.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/widget/verifycodeView_body.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/widget/CustomAppbar.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class VerifycodeView extends StatelessWidget {
  const VerifycodeView({super.key});
  //final String codeitem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(), body: VerifycodeviewBody());
  }
}
