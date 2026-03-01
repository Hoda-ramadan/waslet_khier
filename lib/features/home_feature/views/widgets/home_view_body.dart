import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/charities.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/custom_ai_card.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/home_view_first_part.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: const Column(
        children: [
       HomeViewFirstPart(),
       SizedBox(
        height: 8,
       ),
       CustomAiCard(),
        SizedBox(
        height: 10,
       ),
        Charities(),
        SizedBox(
        height: 10,
       ),
       States(),
      
        ],
      ),
    );
  }
}