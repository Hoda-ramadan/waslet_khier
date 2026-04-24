import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/data/cubit/Aicases_cubit/AicasesCubit.dart';
import 'package:waslet_khier/features/home_feature/data/cubit/Aicases_cubit/Aicases_state.dart';
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
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HomeViewFirstPart()),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // ✅ AI Cases
          SliverToBoxAdapter(
            child: BlocBuilder<AiCasesCubit, AiCasesState>(
              builder: (context, state) {
                if (state is AiCasesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: appcolor),
                  );
                } else if (state is AiCasesSuccess) {
                  return SizedBox(
                    ////// card height(180) + blurRadius(6) + offsetY(2) + padding(8) = 196 → 200
                    height: 180, // best
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(bottom: 8, top: 4),
                      itemCount: state.cases.length,
                      itemBuilder: (context, index) {
                        final aiCase = state.cases[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              context.push(
                                '/cases/case_detals_view',
                                extra: state.cases[index],
                              );
                            },
                            child: CustomAiCard(aiCasesModel: aiCase),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is AiCasesFailure) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return const SizedBox();
              },
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(child: Charities()),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(child: States()),
        ],
      ),
    );
  }
}
