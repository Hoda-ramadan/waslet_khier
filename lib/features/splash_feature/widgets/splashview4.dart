import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/splash_feature/widgets/customindecator.dart';
import 'package:waslet_khier/features/splash_feature/widgets/splashview3.dart';

class Splashview4 extends StatelessWidget {
  const Splashview4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),
      body: Splash_View4_body(),
    );
  }
}

class Splash_View4_body extends StatelessWidget {
  const Splash_View4_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SplashView3();
                  },
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios, color: tintAppColor),
          ),
          Center(child: Image.asset("assets/images/Frame 18.png")),
          ListTile(
            title: Text(
              "تتبّع أثر تبرعك",
              style: TextStyle(fontSize: 24, fontFamily: "Roboto"),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              "اعرف تبرعك رايح فين وتابع تأثيره الحقيقي من خلال تحديثات وتقارير واضحة.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          CustomIndicator(currentIndex: 2),
          SizedBox(height: 20),
          Custombuttom(
            onPressed: () {},
            text: "التالي",
            color: tintAppColor,
            textcolor: Colors.white,
          ),
        ],
      ),
    );
  }
}
