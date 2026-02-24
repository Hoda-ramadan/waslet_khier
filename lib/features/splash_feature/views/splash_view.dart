import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/features/home_feature/views/home_page.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
   void initState() {
    super.initState();
    goToHome();
  }
void goToHome() {
  Future.delayed(const Duration(seconds: 3), () {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  });
}

  Widget build(BuildContext context) {
    return 
    Scaffold(
     backgroundColor: backGroundColor,
     body: Center(
       child: SizedBox(
        width:343 ,
        height: 343,
        child: Image.asset(Assets.splashLogo),
       ),
     ),
    );
  }
}