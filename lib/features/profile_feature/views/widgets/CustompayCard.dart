import 'package:flutter/material.dart';

class CustomPayCard extends StatelessWidget {
  const CustomPayCard({super.key, required this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),

        child: Column(
          children: [
            Text(
              txt,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "ج.م",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
