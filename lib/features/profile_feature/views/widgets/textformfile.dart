import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class CustomTextfieldForPayment extends StatelessWidget {
  const CustomTextfieldForPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          hint: Row(
            children: [
              Text("مبلغ آخر", style: TextStyle(fontSize: 16)),
              Spacer(),
              Text(
                "ج.م",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: tintAppColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: tintAppColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: tintAppColor),
          ),
        ),
      ),
    );
  }
}
