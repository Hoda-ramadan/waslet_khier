import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class Charity_image extends StatelessWidget {
  const Charity_image({super.key, required this.image});
  final String image ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 296,
      height: 124,
      decoration: BoxDecoration(
        border: Border.all(color: tintAppColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.network(
        image ,
        width: 203,
        height: 100,
        fit: BoxFit.fill,
      ),
    );
  }
}
