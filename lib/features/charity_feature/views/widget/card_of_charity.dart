import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class CardOfCharity extends StatelessWidget {
  const CardOfCharity({
    super.key,
    required this.icon,
    required this.charitydata,
    required this.charitydataType,
  });
  final String charitydataType;
  final IconData icon;
  final String charitydata;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 91,
      decoration: BoxDecoration(
        border: Border.all(color: tintAppColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: tintAppColor),
            Text(charitydata, style: TextStyle(fontWeight: FontWeight.w600)),
            Text(
              charitydataType,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
