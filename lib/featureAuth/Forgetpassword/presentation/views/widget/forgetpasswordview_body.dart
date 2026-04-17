import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/textfield.dart';

class ForgetPasswordView_body extends StatelessWidget {
  const ForgetPasswordView_body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Custom_Appbar(),
            SizedBox(height: 20),
            Container(
              height: 277,
              width: 302,
              child: SvgPicture.asset(
                Assets.forgetpasswordimage,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text("هل نسيت كلمة المرور؟", textAlign: TextAlign.end),
              subtitle: Text(
                "يرجى ادخال البريد الالكتروني لتغيير كلمة المرور",
                textAlign: TextAlign.end,
              ),
            ),
            SizedBox(height: 20),

            CustomTextField(
              labelText: "البريد الالكتروني",
              hintTtxt: "",
              prefxIcon: FontAwesomeIcons.envelope,
              isSuffixIcon: false,
            ),
            SizedBox(height: 20),
            Custombuttom(
              text: "التالي",
              color: appcolor,
              textcolor: Colors.white,
              onPressed: () {
                context.push('/profile/logout/forgetpassword/VerifycodeView');
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
