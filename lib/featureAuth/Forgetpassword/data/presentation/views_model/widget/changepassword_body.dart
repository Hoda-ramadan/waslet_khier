import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/textfield.dart';

class ChangepasswordBody extends StatelessWidget {
  const ChangepasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
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
          Textfild(
            hint: "كلمة المرور",
            prefixicon: Icons.lock_outline,
            suffixicon: Icons.visibility_off_outlined,
          ),
          SizedBox(height: 17),
          Textfild(
            hint: "تاكيد كلمة المرور ",
            prefixicon: Icons.lock_outline,
            suffixicon: Icons.visibility_off_outlined,
          ),
          SizedBox(height: 17),
          Custombuttom(text: "تغيير", color: appcolor, textcolor: Colors.white),
        ],
      ),
    );
  }
}
