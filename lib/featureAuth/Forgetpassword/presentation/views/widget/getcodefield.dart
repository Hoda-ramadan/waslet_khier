import 'package:flutter/material.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/getcode_item.dart';

class Getcodefield extends StatelessWidget {
  const Getcodefield({
    super.key,
    required this.controllers,
    required this.focusNodes,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GetcodeItem(
            controller: controllers[index],
            currentFocus: focusNodes[index],
          ),
        );
      }),
    );
  }
}
