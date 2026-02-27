import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/core/class/showsuccessdialog.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/textfield.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
            perfixicon: Icons.person,
          ),
          SizedBox(height: 20),
          Textfild(
            onChanged: (value) {
              secondname = value;
            },
            hint: "الاسم الثاني",
            perfixicon: Icons.person,
          ),
          SizedBox(height: 20),
          Textfild(
            onChanged: (value) {
              phonnumber = value;
            },
            hint: "رقم الهاتف ",
            perfixicon: Icons.phone,
          ),
          SizedBox(height: 20),
          Textfild(
            onChanged: (value) {
              email = value;
            },
            hint: 'البريد الالكتروني',
            perfixicon: FontAwesomeIcons.envelope,
          ),

          SizedBox(height: 20),
          Textfild(
            onChanged: (value) {
              password1 = value;
            },
            hint: "كلمة المرور",
            perfixicon: Icons.lock_outline,
            suffixicon: Icons.visibility_off_outlined,
          ),
          SizedBox(height: 20),
          Textfild(
            onChanged: (value) {
              password2 = value;
            },
            hint: "تاكيد كلمة المرور ",
            perfixicon: Icons.lock_outline,
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
              try {
                var auth = FirebaseAuth.instance;
                UserCredential user = await auth.createUserWithEmailAndPassword(
                  password: password1!,
                  email: email!,
                );
                showSuccessDialog(context);
              } on FirebaseAuthException catch (e) {
                String msg = "حدث خطأ";
                if (e.code == "email_arleady_in_use") {
                  msg = "الايميل مستخدم بالفعل ";
                } else if (e.code == "weak_password") {
                  msg = "كلمة المرور ضعيفة";
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(msg), backgroundColor: Colors.red),
                );
              }
            },
            text: "انشاء",
            color: appcolor,
            textcolor: Colors.white,
          ),
        ],
      ),
    );
  }
}
