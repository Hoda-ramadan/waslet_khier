import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/textfield.dart';

class ChangepasswordBody extends StatelessWidget {
  const ChangepasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Custom_Appbar(),
            SvgPicture.asset(
              Assets.loginimage,
              fit: BoxFit.fill,
              width: 247,
              height: 254,
            ),
            Text(
              "انشئ كلمة مرور جديدة",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 17),

            CustomTextField(
              labelText: "كلمة المرور",
              hintTtxt: '',
              prefxIcon: Icons.lock_outline,
              isSuffixIcon: true,
            ),

            SizedBox(height: 17),
            CustomTextField(
              labelText: "تاكيد كلمة المرور ",
              hintTtxt: '',
              prefxIcon: Icons.lock_outline,
              isSuffixIcon: true,
            ),

            SizedBox(height: 17),
            Custombuttom(
              onPressed: () {},
              text: "تغيير",
              color: appcolor,
              textcolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
