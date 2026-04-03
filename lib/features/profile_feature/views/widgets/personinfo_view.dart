import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_arrow.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_favorite_border.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        leading: Center(child: Custom_arrow()),
        title: Center(child: Text("تفاصيل الجمعية")),
        backgroundColor: backGroundColor,
        actions: [Custom_favorite_border()],
      ),
    );
  }
}
