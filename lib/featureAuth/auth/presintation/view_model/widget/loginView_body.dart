import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/core/class/showsnackbar.dart';
import 'package:waslet_khier/core/class/showsuccessdialog.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/check_haveing_acc.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/rememberme.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/textfield.dart'
    hide Textfild;

class LoginviewBody extends StatefulWidget {
  LoginviewBody({super.key});

  @override
  State<LoginviewBody> createState() => _LoginviewBodyState();
}

class _LoginviewBodyState extends State<LoginviewBody> {
  GlobalKey<FormFieldState> formkey = GlobalKey();
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 30),
                Image.asset(Assets.logoimage, width: 151, height: 151),
                SizedBox(height: 30),

                CustomTextField(
                  labelText: 'البريد الالكتروني',
                  hintTtxt: '',
                  prefxIcon: FontAwesomeIcons.envelope,
                  isSuffixIcon: false,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  labelText: 'كلمة المرور',
                  hintTtxt: '',
                  prefxIcon: Icons.lock_outline,
                  isSuffixIcon: true,
                ),
                SizedBox(height: 10),
                RememberMe(),
                SizedBox(height: 30),
                Custombuttom(
                  onPressed: () async {
                    try {
                      await login_user(context);
                    } on FirebaseAuthException catch (e) {
                      showsnackbar(e, context);
                    } catch (ex) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(ex.toString()),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  text: "تسجيل الدخول",
                  color: appcolor,
                  textcolor: Colors.white,
                ),
                SizedBox(height: 24),
                checkhavingAcc(
                  text1: ' ليس لديك حساب ؟ ',
                  text2: 'تسجيل حساب',
                  textcolor1: Colors.black,
                  textcolor2: Colors.deepOrange,
                  path: '/createacc',
                ),
                SizedBox(height: 60),
                Custombuttom(
                  onPressed: () {},
                  text: "الدخول كزائر",
                  color: Colors.white,
                  textcolor: appcolor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login_user(BuildContext context) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(password: password!, email: email!);
    showSuccessDialog(context);
  }
}
