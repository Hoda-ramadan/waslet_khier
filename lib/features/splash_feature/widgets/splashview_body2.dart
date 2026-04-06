import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/features/splash_feature/widgets/customindecator.dart';
import 'package:waslet_khier/features/splash_feature/widgets/splashview3.dart';

class Splash_View_body extends StatelessWidget {
  const Splash_View_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Text(
                "تخطي",
                style: TextStyle(
                  color: tintAppColor,
                  decoration: TextDecoration.underline,
                  decorationColor: tintAppColor,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Center(child: Image.asset("assets/images/Frame 12.png")),
            ListTile(
              title: Text(
                "تبرع بسهولة في أي وقت",
                style: TextStyle(fontSize: 24, fontFamily: "Roboto"),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                "ساهم في تغيير حياة شخص محتاج بخطوات بسيطة وسريعة يسهّل تطبيقنا عليك الوصول للحالات وإتمام التبرع بشكل آمن وشفاف.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 35),
            CustomIndicator(currentIndex: 0),
            SizedBox(height: 35),
            Custombuttom(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SplashView3();
                    },
                  ),
                );
              },
              text: "التالي",
              color: tintAppColor,
              textcolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
