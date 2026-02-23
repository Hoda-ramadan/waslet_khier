import 'package:flutter/material.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/login_view.dart';
import 'package:waslet_khier/features/splash_feature/views/splash_view.dart';

void main() {
  runApp(const Waslet_Khier());
}

class Waslet_Khier extends StatelessWidget {
  const Waslet_Khier({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:SplashView(), debugShowCheckedModeBanner: false);
  }
}
