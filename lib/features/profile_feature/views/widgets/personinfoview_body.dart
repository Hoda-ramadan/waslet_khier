import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/customtextformfeild.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class PersoninfoView_body extends StatelessWidget {
  const PersoninfoView_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10),
            customappbar(text: "المعلومات الشخصية"),
            Center(
              child: Image.asset(
                "assets/images/radix-icons_avatar (1).png",
                width: 70,
                height: 105,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "الاسم الاول",
              style: TextStyle(fontSize: 16, fontFamily: "Roboto"),
            ),
            customtextformfeild(initalvalue: 'Nourhan', icon: Icons.person),
            SizedBox(height: 10),
            Text(
              "الاسم التانى",
              style: TextStyle(fontSize: 16, fontFamily: "Roboto"),
            ),
            customtextformfeild(initalvalue: "Faisal", icon: Icons.person),
            SizedBox(height: 10),
            Text(
              "البريد الالكتروني",
              style: TextStyle(fontSize: 16, fontFamily: "Roboto"),
            ),
            customtextformfeild(
              initalvalue: "nour@gmail.com",
              icon: Icons.email,
            ),
            SizedBox(height: 10),
            Text(
              "رقم الهاتف",
              style: TextStyle(fontSize: 16, fontFamily: "Roboto"),
            ),
            customtextformfeild(
              initalvalue: "011234556",
              icon: Icons.smartphone,
            ),
            SizedBox(height: 30),
            GestureDetector(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Icon(Icons.lock_clock_outlined, color: tintAppColor),
                    Text(
                      "تغيير كلمة المرور",
                      style: TextStyle(color: tintAppColor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Custombuttom(
              onPressed: () {},
              text: "حفظ التعديلات",
              color: tintAppColor,
              textcolor: Colors.white,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
