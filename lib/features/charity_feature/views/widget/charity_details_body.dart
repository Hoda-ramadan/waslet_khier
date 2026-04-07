import 'package:flutter/material.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityimage.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/collectionOfcards.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customsections.dart';
import 'package:waslet_khier/features/home_feature/data/models/state_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states_card.dart';
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
          Padding(
            padding: const EdgeInsets.only(right: 35, bottom: 10),
            child: Align(
              alignment: AlignmentGeometry.bottomEnd,
              child: Text(
                "الاقسام",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          CustomSections(),
          Padding(
            padding: const EdgeInsets.only(right: 35, bottom: 10),
            child: Align(
              alignment: AlignmentGeometry.bottomEnd,
              child: Text(
                "الحالات",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          StatesCard(stateModel: StateModel()),
        ],
      ),
    );
  }
}
