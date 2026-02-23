import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VerifycodeviewBody extends StatelessWidget {
  const VerifycodeviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 277,
          width: 302,
          child: SvgPicture.asset(
            'assets/images/two-factor-authentication/rafiki.svg',
            fit: BoxFit.fill,
          ),
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
        pincodetextfield(),
      ],
    );
  }
}
