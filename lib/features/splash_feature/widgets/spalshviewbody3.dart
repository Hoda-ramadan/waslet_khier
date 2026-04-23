import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/features/splash_feature/widgets/customindecator.dart';
import 'package:waslet_khier/features/splash_feature/widgets/splash_view2.dart';
import 'package:waslet_khier/features/splash_feature/widgets/splashview4.dart';

class Splash_View3_body extends StatelessWidget {
  const Splash_View3_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SplashView2();
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios, color: tintAppColor),
                ),
              ],
            ),
            Center(child: Image.asset("assets/images/Frame 13.png")),
            ListTile(
              title: Text(
                "مساهمتك بتغير حياة",
                style: TextStyle(fontSize: 24, fontFamily: "Roboto"),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                "نربط تبرعك بالحالات الأكثر احتياجًا ونقدّم لك طرق مختلفة للمساهمة علشان تقدر تختار الخير اللي تحب توصله.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            CustomIndicator(currentIndex: 1),
            SizedBox(height: 20),
            Custombuttom(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Splashview4();
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
