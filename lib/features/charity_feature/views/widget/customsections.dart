import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/sections_of_charity.dart';

class CustomSections extends StatelessWidget {
  const CustomSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("الاقسام", style: TextStyle(fontSize: 24)),
        Row(
          children: [
            SectionsOfCharity(
              icon: FontAwesomeIcons.handHoldingHeart,
              name: "الغرامات",
              iconcolor: appcolor,
            ),
            SizedBox(width: 20),
            SectionsOfCharity(
              icon: Icons.water_drop_rounded,
              name: "ابار",
              iconcolor: Color(0xFF8FBFFA),
            ),
            SizedBox(width: 20),
            SectionsOfCharity(
              icon: Icons.favorite,
              name: "الصحة",
              iconcolor: Colors.red,
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            SectionsOfCharity(
              icon: FontAwesomeIcons.personDress,
              name: "تجهيز عرايْس",
              iconcolor: Colors.red,
            ),
            SizedBox(width: 20),
            SectionsOfCharity(
              icon: FontAwesomeIcons.tree,
              name: "مناحي الحياة",
              iconcolor: Colors.green,
            ),
            SizedBox(width: 20),
            SectionsOfCharity(
              icon: FontAwesomeIcons.graduationCap,
              name: "التعليم",
              iconcolor: appcolor,
            ),
          ],
        ),
      ],
    );
  }
}
