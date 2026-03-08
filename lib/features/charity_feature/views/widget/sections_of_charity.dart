import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class SectionsOfCharity extends StatelessWidget {
  const SectionsOfCharity({
    super.key,
    required this.icon,
    required this.name,
    required this.iconcolor,
  });
  final IconData icon;
  final String name;
  final Color iconcolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 104,
      decoration: BoxDecoration(
        border: Border.all(color: tintAppColor, width: .5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconcolor),
          Text(name),
        ],
      ),
    );
  }
}
