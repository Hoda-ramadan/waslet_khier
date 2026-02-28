import 'package:flutter/material.dart';

class AiCardDonationImage extends StatelessWidget {
  final double width;
  final double height;

  const AiCardDonationImage({super.key, this.width = 118, this.height = 118});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: AssetImage('assets/images/food.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 4),
          )
        ],
      ),
    );
  }
}