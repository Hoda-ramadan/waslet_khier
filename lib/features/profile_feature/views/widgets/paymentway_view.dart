import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/pymentoption_item.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/payment_body.dart';

class PaymentwayView extends StatelessWidget {
  const PaymentwayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),
      body: Payment_body(),
    );
  }
}
