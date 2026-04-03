import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class charityicon extends StatelessWidget {
  const charityicon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 88,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: tintAppColor),
      ),
      child: Image.asset(
        "assets/images/مركز علاج الاورام.png",
        width: 67,
        height: 67,
        fit: BoxFit.contain,
      ),
    );
  }
}
