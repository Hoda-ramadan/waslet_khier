import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/textfield.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/customtextformfeild.dart';

class PersoninfoView_body extends StatelessWidget {
  const PersoninfoView_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/radix-icons_avatar (1).png",
              width: 70,
              height: 105,
            ),
            SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(height: 20, child: Text("الاسم الاول")),
            ),
            customtextformfeild(initalvalue: 'Nourhan', icon: Icons.person),
            SizedBox(height: 20, child: Text("الاسم التانى")),
            customtextformfeild(initalvalue: "Faisal", icon: Icons.person),
            SizedBox(height: 20, child: Text("البريد الالكتروني")),
            customtextformfeild(
              initalvalue: "nour@gmail.com",
              icon: Icons.email,
            ),
            SizedBox(height: 20, child: Text("رقم الهاتف")),
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
              color: appcolor,
              textcolor: Colors.white,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
