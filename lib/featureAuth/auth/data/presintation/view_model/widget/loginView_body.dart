import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';

class LoginviewBody extends StatelessWidget {
  const LoginviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Image.asset(Assets.logoimage, width: 151, height: 151)),
        Textfild(),
      ],
    );
  }
}

class Textfild extends StatelessWidget {
  const Textfild({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 151,
        width: 404,
        child: TextField(
          style: TextStyle(),

          textAlign: TextAlign.end,
          decoration: InputDecoration(
            hintTextDirection: TextDirection.rtl,
            hint: hint,
            hintMaxLines: 1,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}
