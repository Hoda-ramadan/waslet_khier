import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class Custom_favorite_border extends StatelessWidget {
  const Custom_favorite_border({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 44,
      width: 42,
      child: Center(
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border, color: tintAppColor),
        ),
      ),
    );
  }
}
