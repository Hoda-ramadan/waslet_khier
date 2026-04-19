import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class cstomItem extends StatelessWidget {
  const cstomItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, top: 10),
      height: 82,
      decoration: BoxDecoration(
        border: Border.all(color: tintAppColor),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.school, color: appcolor),
              Text(
                "التعليم",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: appcolor,
                ),
              ),
            ],
          ),
          Text(
            "تبرعك اليوم يمنح طفلًا فرصة للتعلم غدًا",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
