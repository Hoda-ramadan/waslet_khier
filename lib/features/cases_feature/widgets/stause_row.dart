import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/card_of_charity.dart';

class StauseRow extends StatelessWidget {
  const StauseRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardOfCharity(icon: FontAwesomeIcons.person, charitydata: "1M ج.م"),
        SizedBox(width: 20),
        CardOfCharity(icon: Icons.timelapse_outlined, charitydata: "5k  متبرع"),
        SizedBox(width: 20),
        CardOfCharity(icon: Icons.attach_money_outlined, charitydata: "20 مشروع"),
      ],
    );
  }
}