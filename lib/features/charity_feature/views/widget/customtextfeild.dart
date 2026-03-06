import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class Customtextfeild extends StatelessWidget {
  const Customtextfeild({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: tintAppColor),

          label: Text("بحث عن الجمعية/الموْسسة"),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tintAppColor, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: tintAppColor),
          ),
        ),
      ),
    );
  }
}
