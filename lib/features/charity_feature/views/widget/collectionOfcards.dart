import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/card_of_charity.dart';

class colletionOfcard extends StatelessWidget {
  const colletionOfcard({
    super.key,
    required this.totalProjectsCount,
    required this.totalRaisedAmount,
    required this.totalDonorsCount,
  });
  final int totalProjectsCount;
  final int totalRaisedAmount;
  final int totalDonorsCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardOfCharity(
          icon: FontAwesomeIcons.coins,
          charitydata: '$totalRaisedAmount',
          charitydataType: 'ج.م',
        ),
        SizedBox(width: 20),
        CardOfCharity(
          icon: Icons.person,
          charitydata: '$totalDonorsCount',
          charitydataType: 'متبرع',
        ),
        SizedBox(width: 20),
        CardOfCharity(
          icon: Icons.business,
          charitydata: '$totalProjectsCount',
          charitydataType: 'مشروع',
        ),
      ],
    );
  }
}
