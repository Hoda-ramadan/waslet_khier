import 'package:flutter/material.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/getcode_item.dart';

class Getcodefield extends StatelessWidget {
  const Getcodefield({super.key, required this.codeitem});
  final String codeitem;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetcodeItem(
          codeitem: codeitem,
          controller: TextEditingController(),
          currentFocus: FocusNode(),
        ),
        SizedBox(width: 10),
        GetcodeItem(
          codeitem: codeitem,
          controller: TextEditingController(),
          currentFocus: FocusNode(),
        ),
        SizedBox(width: 10),
        GetcodeItem(
          codeitem: codeitem,
          controller: TextEditingController(),
          currentFocus: FocusNode(),
        ),
        SizedBox(width: 10),
        GetcodeItem(
          codeitem: codeitem,
          controller: TextEditingController(),
          currentFocus: FocusNode(),
        ),
        SizedBox(width: 10),
        GetcodeItem(
          codeitem: codeitem,
          controller: TextEditingController(),
          currentFocus: FocusNode(),
        ),
        SizedBox(width: 10),
        GetcodeItem(
          codeitem: codeitem,
          controller: TextEditingController(),
          currentFocus: FocusNode(),
        ),
      ],
    );
  }
}
