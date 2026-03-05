import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/data/models/state_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states_card.dart';

class StatesCardGridView extends StatelessWidget {
  const StatesCardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        
        itemBuilder: (context , index){
         
           return Padding(
             padding: const EdgeInsets.only(left: 12),
             child: StatesCard(stateModel: StateModel()),
           );
      }),
    );
  }
}