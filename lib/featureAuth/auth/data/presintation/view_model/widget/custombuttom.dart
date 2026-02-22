import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class Custombuttom extends StatelessWidget {
  const Custombuttom({
    super.key,
    required this.text,
    required this.color,
    required this.textcolor,
  });
  final String text;
  final Color color;
  final Color textcolor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 343,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: appcolor),
          backgroundColor: color,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        child: Text(text, style: TextStyle(fontSize: 18, color: textcolor)),
      ),
    );
  }
}
