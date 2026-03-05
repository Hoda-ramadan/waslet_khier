import 'package:flutter/material.dart';

class DonateNowButtom extends StatelessWidget {
  final double width;
  final double height;
 final  double fontSize;
  const DonateNowButtom({super.key, this.width = 118, this.height = 36, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFFFF8A3D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'تبرع الآن',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}