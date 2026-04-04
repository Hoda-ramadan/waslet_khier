import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class SplashView2 extends StatelessWidget {
  const SplashView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Splash_View_body(),
      backgroundColor: backGroundColor,
    );
  }
}

class Splash_View_body extends StatelessWidget {
  const Splash_View_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Text(
              "تخطي",
              style: TextStyle(color: tintAppColor),
              textAlign: TextAlign.end,
            ),
            Image.asset("assets/images/Frame 12.png"),
            ListTile(
              title: Text(
                "تبرع بسهولة في أي وقت",
                style: TextStyle(fontSize: 24, fontFamily: "Roboto"),
              ),
              subtitle: Text(
                "ساهم في تغيير حياة شخص محتاج بخطوات بسيطة وسريعة. يسهّل تطبيقنا عليك الوصول للحالات وإتمام التبرع بشكل آمن وشفاف.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
