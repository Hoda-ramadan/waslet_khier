import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/state_view.dart';

class FavoriteView_body extends StatelessWidget {
  const FavoriteView_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10),
            customappbar(text: "المفضلة"),
            SizedBox(height: 20),
            Image.asset(
              "assets/images/no-data/pana.png",
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              "قاىْمة المفضلة فارغة",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "كن اول من يزرع بذور الخير! استكشف الحالات الانسانية المميزة واضف ما يلهمك الي صندوق مفضلاتك",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  color: Color(0xFF696B6A),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 35),
            Custombuttom(
              icon: Icons.explore,
              onPressed: () {},
              text: "استكشف الحالات الان",
              color: appcolor,
              textcolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
