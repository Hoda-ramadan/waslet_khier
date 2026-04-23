import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  const CustomIndicator({
    super.key,
    required this.currentIndex,
    this.count = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
          return Container(
            // duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: currentIndex == index ? Color(0xFFFF8C42) : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }),
      ),
    );
  }
}
