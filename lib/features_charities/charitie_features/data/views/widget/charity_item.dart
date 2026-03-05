import 'package:flutter/material.dart';
import 'package:waslet_khier/features_charities/charitie_features/data/views/widget/charityicon.dart';

class CharityItem extends StatelessWidget {
  const CharityItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(children: [charityicon()]),
    );
  }
}
