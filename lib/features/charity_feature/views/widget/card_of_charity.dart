import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class CardOfCharity extends StatelessWidget {
  const CardOfCharity({
    super.key,
    required this.icon,
    required this.charitydata,
  });
  final IconData icon;
  final String charitydata;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      height: 91,
      decoration: BoxDecoration(
        border: Border.all(color: tintAppColor, width: .5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: tintAppColor),
            Text(charitydata),
          ],
        ),
      ),
    );
  }
}
