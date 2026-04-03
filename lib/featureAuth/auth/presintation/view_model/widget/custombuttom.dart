import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class Custombuttom extends StatelessWidget {
  const Custombuttom({
    super.key,
    required this.text,
    required this.color,
    required this.textcolor,
    this.onPressed,
    this.icon,
  });
  final String text;
  final Color color;
  final Color textcolor;
  final void Function()? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: appcolor),
          backgroundColor: color,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: textcolor,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(icon, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
