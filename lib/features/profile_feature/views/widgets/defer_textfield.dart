import 'package:flutter/material.dart';

class customField extends StatelessWidget {
  const customField({
    super.key,
    required this.label,
    required this.hint,
    this.suffixIcon,
  });
  final String label;
  final String hint;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Roboto",

              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 4),
          TextField(
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hint,
              labelStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
