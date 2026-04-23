import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';

class PymentoptionItem extends StatelessWidget {
  const PymentoptionItem({super.key, required this.image, required this.text});

  final String image, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 104,
          width: 94,
          decoration: BoxDecoration(
            //color: Colors.white,
            border: Border.all(color: tintAppColor, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(image, fit: BoxFit.fill),
        ),
        Text(text),
      ],
    );
  }
}
