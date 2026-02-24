import 'package:flutter/material.dart';
import 'package:waslet_khier/feature/forget_password_view.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/widget/verifycode_view.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/login_view.dart';

void main() {
  runApp(const Waslet_Khier());
}

class Waslet_Khier extends StatelessWidget {
  const Waslet_Khier({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "ForgetPassword()": (context) => ForgetPassword(),
        "VerifycodeView()": (context) => VerifycodeView(),
      },
      home: LoginView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
