import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/card_of_charity.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityimage.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/sections_of_charity.dart';

class CharityDetailsView_body extends StatelessWidget {
  const CharityDetailsView_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Charity_image(),
        Text("جمعية رسالة", style: TextStyle(fontSize: 24)),
        Text(
          "مؤسسة خيرية تسعى لتقديم الدعم الشامل للأسر المحتاجة في مجالات الصحة والتعليم والمساعدات الإنسانية.",
        ),
        SizedBox(height: 20),
        Row(
          children: [
            CardOfCharity(icon: FontAwesomeIcons.coins, charitydata: "1M ج.م"),
            SizedBox(width: 20),
            CardOfCharity(icon: Icons.person, charitydata: "5k  متبرع"),
            SizedBox(width: 20),
            CardOfCharity(icon: Icons.business, charitydata: "20 مشروع"),
          ],
        ),
        SizedBox(height: 20),

        Column(
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
        ),
      ],
    );
  }
}
