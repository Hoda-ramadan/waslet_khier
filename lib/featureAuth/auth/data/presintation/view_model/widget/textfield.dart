import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';

class Textfild extends StatelessWidget {
  Textfild({
    super.key,
    required this.hint,
    required this.perfixicon,
    this.suffixicon,
    this.onChanged,
  });
  final String hint;
  final IconData perfixicon;
  final IconData? suffixicon;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 56,
        width: 343,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "القيمة مطلوبة";
            }
          },
          onChanged: onChanged,
          style: TextStyle(),

          textAlign: TextAlign.start,
          decoration: InputDecoration(
            prefixIcon: Icon(perfixicon),
            suffixIcon: IconButton(onPressed: () {}, icon: Icon(suffixicon)),
            //hintTextDirection: TextDirection.rtl,
            label: Text(hint),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintMaxLines: 1,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    );
  }
}
