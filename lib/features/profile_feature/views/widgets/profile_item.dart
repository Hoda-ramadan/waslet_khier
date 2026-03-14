import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class profileItem extends StatelessWidget {
  const profileItem({
    super.key,
    required this.icon,
    required this.text,
    this.color = tintAppColor,
    this.onTap,
  });
  final IconData icon;
  final String text;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.4),
              blurRadius: 5,

              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(icon, color: color),
                SizedBox(width: 7),
                Text(text, style: TextStyle(fontSize: 18)),
                Expanded(child: SizedBox()),
                Icon(Icons.arrow_forward_ios_outlined, color: tintAppColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
