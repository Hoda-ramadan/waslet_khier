import 'package:flutter/material.dart';

class GetcodeItem extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;

  const GetcodeItem({
    super.key,
    required this.controller,
    required this.currentFocus,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Color(0xffC3C7C5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        decoration: InputDecoration(counterText: "", border: InputBorder.none),
      ),
    );
  }
}
