import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/forget_password_view.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/check_haveing_acc.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/rememberme.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/textfield.dart';

class LoginviewBody extends StatelessWidget {
  LoginviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          Image.asset(Assets.logoimage, width: 151, height: 151),
          SizedBox(height: 30),
          Textfild(
            hint: 'البريد الالكتروني',
            perfixicon: FontAwesomeIcons.envelope,
          ),
          SizedBox(height: 10),
          Textfild(
            hint: 'كلمة المرور',
            perfixicon: Icons.lock_outline,
            suffixicon: Icons.visibility_off_outlined,
          ),
          Remeberme(),
          SizedBox(height: 30),
          Custombuttom(
            text: "تسجيل الدخول",
            color: appcolor,
            textcolor: Colors.white,
          ),
          SizedBox(height: 24),
          checkhavingAcc(),
          SizedBox(height: 60),
          Custombuttom(
            text: "الدخول كزائر",
            color: Colors.white,
            textcolor: appcolor,
          ),
        ],
      ),
    );
  }
}
