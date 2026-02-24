import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/widget/getcodefield.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/widget/custombuttom.dart';

class VerifycodeviewBody extends StatelessWidget {
  const VerifycodeviewBody({super.key});
  // final String codeitem;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 277,
            width: 302,
            child: SvgPicture.asset(Assets.verifycodeimage, fit: BoxFit.fill),
          ),
          Text(
            "ادخل رمز التحقق",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            "تم ارسال رمز مكون من 4 ارقام الى بريدك الالكتروني",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF696B6A),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Getcodefield(codeitem: ''),
          SizedBox(height: 20),
          Custombuttom(
            text: "تحقق",
            color: appcolor,
            textcolor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed("ChangepasswordView()");
            },
          ),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(
              "لم يصلك الرمز ؟اعد الارسال (42)",
              style: TextStyle(color: Color(0xFFFF8A3D), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
