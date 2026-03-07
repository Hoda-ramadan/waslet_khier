import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_page_body.dart';

class CharityView extends StatelessWidget {
  const CharityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CharityPageBody(), backgroundColor: backGroundColor);
  }
}
