import 'package:flutter/material.dart';

class Textfild extends StatelessWidget {
  Textfild({
    super.key,
    required this.hint,
    required this.prefixicon,
    this.suffixicon,
    this.onChanged,
  });
  final String hint;
  final IconData prefixicon;
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
            prefixIcon: Icon(prefixicon),
            suffixIcon: IconButton(onPressed: () {}, icon: Icon(suffixicon)),

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
