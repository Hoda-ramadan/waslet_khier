import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/textfield.dart';

class ForgetPasswordView_body extends StatelessWidget {
  const ForgetPasswordView_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            height: 277,
            width: 302,
            child: SvgPicture.asset(
              Assets.forgetpasswordimage,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: ListTile(
              title: Text("هل نسيت كلمة المرور؟"),
              subtitle: Text("يرجى ادخال البريد الالكتروني لتغيير كلمة المرور"),
            ),
          ),
          SizedBox(height: 20),
          Textfild(
            hint: "البريد الالكتروني",
            prefixicon: FontAwesomeIcons.envelope,
          ),
          SizedBox(height: 20),
          Custombuttom(
            text: "التالي",
            color: appcolor,
            textcolor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed("VerifycodeView()");
            },
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
