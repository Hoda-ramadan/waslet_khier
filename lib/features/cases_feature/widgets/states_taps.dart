import 'package:flutter/material.dart';
import 'package:waslet_khier/features/cases_feature/widgets/status_chip.dart';

class StatesTaps extends StatelessWidget {
  const StatesTaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatusChip(
          title: "حالة عاجلة",
          color: Colors.blue.shade50,
          textColor: Colors.blue,
        ),
        const SizedBox(width: 8),
        StatusChip(
          title: "متبقى قليل",
          color: Colors.red.shade50,
          textColor: Colors.red,
        ),
      ],
    );
  }
}
