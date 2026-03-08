import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class Custom_arrow extends StatelessWidget {
  const Custom_arrow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 38,
        width: 37,
        decoration: BoxDecoration(
          color: Color(0xFFF8EAE1),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Icon(Icons.arrow_back_ios, color: orangcolor, size: 18),
      ),
    );
  }
}
