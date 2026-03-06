import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor,
      title: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border, color: tintAppColor),
          ),
        ],
      ),
    );
  }
}
