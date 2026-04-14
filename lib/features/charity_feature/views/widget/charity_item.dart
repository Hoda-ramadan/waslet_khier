import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_detels_view.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityItem_body.dart';

class CharityItem extends StatelessWidget {
  const CharityItem({super.key, required this.icon, this.color});
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return CharityDetelsView();
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: tintAppColor),
            borderRadius: BorderRadius.circular(24),
          ),
          child: charityitem_body(
            icon: icon ?? Icons.arrow_forward_ios_outlined,
            color: color,
          ),
        ),
      ),
    );
  }
}
