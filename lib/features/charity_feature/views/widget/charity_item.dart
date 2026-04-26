import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityItem_body.dart';

class CharityItem extends StatelessWidget {
  const CharityItem({
    super.key,
    required this.charityModel,
    required this.icon,
    this.color,
  });
  final CharityModel charityModel;
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        (context).push('/charities/chaaritedetelies', extra: charityModel);
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
            charityModel: charityModel,
            icon: icon,
            color: color,
          ),
        ),
      ),
    );
  }
}
