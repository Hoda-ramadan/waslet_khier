import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/data/models/state_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states_card.dart';

class CasesViewBody extends StatelessWidget {
  const CasesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 🔥 2 cards in row
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.67,
            ),
            itemBuilder: (context, index) {
              return  StatesCard(stateModel: StateModel());
            },
          ),
    );
    
    
  }
}

