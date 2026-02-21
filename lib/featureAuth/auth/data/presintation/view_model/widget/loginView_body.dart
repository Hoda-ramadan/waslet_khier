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
  //final String hint;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 56,
        width: 404,
        child: TextField(
          style: TextStyle(),

          textAlign: TextAlign.start,
          decoration: InputDecoration(
            prefixIcon: Icon(),
            //hintTextDirection: TextDirection.rtl,
            label: hint,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintMaxLines: 1,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    );
  }
}
