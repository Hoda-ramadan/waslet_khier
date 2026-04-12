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
<<<<<<< HEAD
        MaterialPageRoute(builder: (context) => const HomePage()),
=======
        MaterialPageRoute(builder: (context) => HomePage()),
>>>>>>> 3349deb558fe0c7bec95c97afc532f391854f15c
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Center(
        child: SizedBox(
          width: 343,
          height: 343,
          child: Image.asset(Assets.splashLogo),
        ),
      ),
    );
  }
}
