import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityItem_body.dart';

class CharityItem extends StatelessWidget {
  const CharityItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: tintAppColor, width: .5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(children: [charityitem_body()]),
      ),
    );
  }
}
