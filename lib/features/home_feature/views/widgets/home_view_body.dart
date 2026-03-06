import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/charities.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/custom_ai_card.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/home_view_first_part.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states_card_grid_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: HomeViewFirstPart()),
            SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(child: CustomAiCard()),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(child: Charities()),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(child: States()),
          ],
        ),
      ),
    );
  }
}
