import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/features/home_feature/data/models/state_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states_card.dart';

class StatesCardGridView extends StatelessWidget {
  const StatesCardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: SizedBox(
              width: 163,
<<<<<<< HEAD
              child: StatesCard(stateModel: StateModel()),
=======
              child: GestureDetector(
                onTap: () {
                  (context).push('/home/case_detals_view');
                },
                child: StatesCard(stateModel: StateModel()),
              ),
>>>>>>> 3349deb558fe0c7bec95c97afc532f391854f15c
            ),
          );
        },
      ),
    );
  }
}
