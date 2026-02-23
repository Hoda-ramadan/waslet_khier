import 'package:flutter/material.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/verifycodeView_body.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/CustomAppbar.dart';

class VerifycodeView extends StatelessWidget {
  const VerifycodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Custom_Appbar(), automaticallyImplyLeading: false),
      body: VerifycodeviewBody(),
    );
  }
}
