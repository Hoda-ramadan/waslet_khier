import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class Custom_Appbar extends StatelessWidget {
  const Custom_Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios, color: appcolor),
      ),
    );
  }
}
