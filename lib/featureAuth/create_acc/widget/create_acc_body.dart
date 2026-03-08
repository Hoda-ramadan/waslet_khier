import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/core/class/showsnackbar.dart';
import 'package:waslet_khier/core/class/showsuccessdialog.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/textfield.dart';

class CreateAccBody extends StatefulWidget {
  CreateAccBody({super.key});

  @override
  State<CreateAccBody> createState() => _CreateAccBodyState();
}

class _CreateAccBodyState extends State<CreateAccBody> {
  String? firstname;

  String? secondname;

  String? email;

  String? phonnumber;

  String? password1;

  String? password2;

  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formkey,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.personimage,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
            Text("انشاء حساب", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Textfild(
              onChanged: (value) {
                firstname = value;
              },
              hint: "الاسم الاول",
              prefixicon: Icons.person,
            ),
            SizedBox(height: 20),
            Textfild(
              onChanged: (value) {
                secondname = value;
              },
              hint: "الاسم الثاني",
              prefixicon: Icons.person,
            ),
            SizedBox(height: 20),
            Textfild(
              onChanged: (value) {
                phonnumber = value;
              },
              hint: "رقم الهاتف ",
              prefixicon: Icons.phone,
            ),
            SizedBox(height: 20),
            Textfild(
              onChanged: (value) {
                email = value;
              },
              hint: 'البريد الالكتروني',
              prefixicon: FontAwesomeIcons.envelope,
            ),

            SizedBox(height: 20),
            Textfild(
              onChanged: (value) {
                password1 = value;
              },
              hint: "كلمة المرور",
              prefixicon: Icons.lock_outline,
              suffixicon: Icons.visibility_off_outlined,
            ),
            SizedBox(height: 20),
            Textfild(
              onChanged: (value) {
                password2 = value;
              },
              hint: "تاكيد كلمة المرور ",
              prefixicon: Icons.lock_outline,
              suffixicon: Icons.visibility_off_outlined,
            ),
            SizedBox(height: 20),
            Custombuttom(
              onPressed: () async {
                if (password1 != password2) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("كلمتا المرور غير متطابقتين"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (formkey.currentState!.validate()) {
                  try {
                    await regester_user(context);
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
                }
              },
              text: "انشاء",
              color: appcolor,
              textcolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> regester_user(BuildContext context) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(password: password1!, email: email!);
    showSuccessDialog(context);
  }
}
