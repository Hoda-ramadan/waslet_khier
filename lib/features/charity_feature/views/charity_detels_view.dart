import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_details_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customAppbar.dart';

class CharityDetelsView extends StatelessWidget {
  const CharityDetelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(title: Customappbar(), automaticallyImplyLeading: false),
      body: Center(child: CharityDetailsView_body()),
    );
  }
}
