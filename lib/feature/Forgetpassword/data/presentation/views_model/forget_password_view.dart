import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/CustomAppbar.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/forgetpasswordview_body.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Custom_Appbar(), automaticallyImplyLeading: false),
      body: ForgetPasswordView_body(),
    );
  }
}
