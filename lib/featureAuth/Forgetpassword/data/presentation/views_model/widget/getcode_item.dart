import 'package:flutter/material.dart';

class GetcodeItem extends StatelessWidget {
  const GetcodeItem({super.key, required this.codeitem});
  final String codeitem;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Color(0xffC3C7C5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          codeitem,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
