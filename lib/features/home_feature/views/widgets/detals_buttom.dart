import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class DetalsButtom extends StatelessWidget {
  final double width;
  final double height;
 final  double fontSize;
  const DetalsButtom({super.key, this.width = 118, this.height = 36, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:  const Color(0xFFFAF4FE),
          borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: appcolor,
          width: 1,
        )
          
        ),
        child:  Text(
        'التفاصيل',
        textAlign: TextAlign.right,
        style: TextStyle(
          color: appcolor,
          fontSize: fontSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        ),
      ),
      ),
    );
  }
}