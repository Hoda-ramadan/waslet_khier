import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/paymentviewBank_boad.dart';

class Payment_Bank extends StatelessWidget {
  const Payment_Bank({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: backGroundColor,
      body: PaymentView_Bankbody(),
    );
  }
}
