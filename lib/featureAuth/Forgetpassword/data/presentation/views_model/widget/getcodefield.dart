import 'package:flutter/material.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/widget/getcode_item.dart';

class Getcodefield extends StatelessWidget {
  const Getcodefield({super.key, required this.codeitem});
  final String codeitem;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetcodeItem(codeitem: codeitem),
        SizedBox(width: 20),
        GetcodeItem(codeitem: codeitem),
        SizedBox(width: 20),
        GetcodeItem(codeitem: codeitem),
        SizedBox(width: 20),
        GetcodeItem(codeitem: codeitem),
      ],
    );
  }
}
