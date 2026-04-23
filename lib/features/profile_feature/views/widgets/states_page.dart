import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class StatesPage extends StatelessWidget {
  const StatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),
      body: Statepage_body(),
    );
  }
}

class Statepage_body extends StatelessWidget {
  const Statepage_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
