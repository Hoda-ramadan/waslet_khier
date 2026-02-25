import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/textfield.dart';

class CreateAccBody extends StatelessWidget {
  const CreateAccBody({super.key});

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
          Textfild(hint: "الاسم الاول", perfixicon: Icons.person),
          SizedBox(height: 20),
          Textfild(hint: "الاسم الثاني", perfixicon: Icons.person),
          SizedBox(height: 20),
          Textfild(hint: "رقم الهاتف ", perfixicon: Icons.phone),
          SizedBox(height: 20),
          Textfild(
            hint: "كلمة المرور",
            perfixicon: Icons.lock_outline,
            suffixicon: Icons.visibility_off_outlined,
          ),
          SizedBox(height: 20),
          Textfild(
            hint: "تاكيد كلمة المرور ",
            perfixicon: Icons.lock_outline,
            suffixicon: Icons.visibility_off_outlined,
          ),
          SizedBox(height: 20),
          Custombuttom(text: "انشاء", color: appcolor, textcolor: Colors.white),
        ],
      ),
    );
  }
}
