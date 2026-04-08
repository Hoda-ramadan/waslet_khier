import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class ConnectingInfo extends StatelessWidget {
  const ConnectingInfo({
    super.key,
    required this.icon,
    required this.text,
    required this.subtext,
    this.fontsize1,
    this.fontsize2,
    this.iconcolor,
  });
  final IconData icon;
  final String text;
  final String subtext;
  final double? fontsize1, fontsize2;
  final Color? iconcolor;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: tintAppColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconcolor ?? tintAppColor),
            SizedBox(width: 8),
            Column(
              children: [
                Text(
                  text,
                  style: TextStyle(color: Colors.grey, fontSize: fontsize1),
                ),
                Text(
                  subtext,
                  style: TextStyle(color: Colors.grey, fontSize: fontsize2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
