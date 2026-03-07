import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityimage.dart';

class CharityDetailsView_body extends StatelessWidget {
  const CharityDetailsView_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Charity_image(),
          Text("جمعية رسالة", style: TextStyle(fontSize: 24)),
          Text(
            "مؤسسة خيرية تسعى لتقديم الدعم الشامل للأسر المحتاجة في مجالات الصحة والتعليم والمساعدات الإنسانية.",
          ),
        ],
      ),
    );
  }
}
