import 'package:flutter/material.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityimage.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/collectionOfcards.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customsections.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/personinfo_view.dart';

class CharityDetailsView_body extends StatelessWidget {
  const CharityDetailsView_body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Customappbar(),

          Charity_image(),
          Text(
            "جمعية رسالة",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: "Roboto",
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "مؤسسة خيرية تسعى لتقديم الدعم الشامل للأسر المحتاجة في مجالات الصحة والتعليم والمساعدات الإنسانية.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Roboto",
                color: Color(0xFF696B6A),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 20),
          colletionOfcard(),
          SizedBox(height: 20),

          CustomSections(),
        ],
      ),
    );
  }
}
