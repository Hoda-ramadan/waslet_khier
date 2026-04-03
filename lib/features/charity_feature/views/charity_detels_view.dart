import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_details_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class CharityDetelsView extends StatelessWidget {
  const CharityDetelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(child: CharityDetailsView_body()),
      ),
    );
  }
}
