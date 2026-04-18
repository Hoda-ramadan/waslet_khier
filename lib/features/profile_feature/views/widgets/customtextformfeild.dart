import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class customtextformfeild extends StatelessWidget {
  const customtextformfeild({
    super.key,
    required this.icon,
    required this.controller,
  });
  final TextEditingController? controller;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: tintAppColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: tintAppColor),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: tintAppColor),
          ),
        ),
      ),
    );
  }
}
