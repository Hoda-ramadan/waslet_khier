import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/card_of_charity.dart';

class colletionOfcard extends StatelessWidget {
  const colletionOfcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardOfCharity(icon: FontAwesomeIcons.coins, charitydata: "1M ج.م"),
        SizedBox(width: 20),
        CardOfCharity(icon: Icons.person, charitydata: "5k  متبرع"),
        SizedBox(width: 20),
        CardOfCharity(icon: Icons.business, charitydata: "20 مشروع"),
      ],
    );
  }
}
