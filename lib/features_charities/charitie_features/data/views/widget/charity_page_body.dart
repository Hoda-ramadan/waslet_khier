import 'package:flutter/material.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/textfield.dart';
import 'package:waslet_khier/features_charities/charitie_features/data/views/widget/charity_item.dart';

class CharityPageBody extends StatelessWidget {
  const CharityPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 50),
          Textfild(hint: "البحث عن الجمعية/الموْسسة", prefixicon: Icons.search),
          SizedBox(height: 30),
          CharityItem(),
        ],
      ),
    );
  }
}
