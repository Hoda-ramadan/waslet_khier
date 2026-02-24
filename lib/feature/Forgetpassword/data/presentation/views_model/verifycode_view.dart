import 'package:flutter/material.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/widget/verifycodeView_body.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/widget/CustomAppbar.dart';

class VerifycodeView extends StatelessWidget {
  const VerifycodeView({super.key});
  //final String codeitem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Custom_Appbar(), automaticallyImplyLeading: false),
      body: VerifycodeviewBody(),
    );
  }
}
