import 'package:flutter/material.dart';

class CustomPayCard extends StatelessWidget {
  const CustomPayCard({super.key, required this.txt});

  final String txt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // تقدر تضيفي اختيار هنا
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              txt,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text("ج.م", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
