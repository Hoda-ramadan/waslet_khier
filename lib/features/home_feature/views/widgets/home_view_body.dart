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

  Future<void> _onRefresh(BuildContext context) async {
    // ✅ Call all your cubits refresh here
    context.read<AiCasesCubit>().getAiCases();
    // add more cubits refresh calls here if needed e.g:
    // context.read<CharityCubit>().getCharites();
    // context.read<StatesCubit>().getStates();

    // Wait until AiCases is no longer loading
    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      final state = context.read<AiCasesCubit>().state;
      return state is AiCasesLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiCasesCubit, AiCasesState>(
      builder: (context, state) {
        // ✅ Single global loading indicator in middle of screen
        if (state is AiCasesLoading) {
          return const Center(
            child: CircularProgressIndicator(color: tintAppColor),
          );
        }

        return RefreshIndicator(
          color: tintAppColor,
          onRefresh: () => _onRefresh(context),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: HomeViewFirstPart()),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                // ✅ AI Cases
                if (state is AiCasesSuccess)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 180,
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
                    ),
                  ),

                if (state is AiCasesFailure)
                  SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${state.error}')),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                const SliverToBoxAdapter(child: Charities()),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                const SliverToBoxAdapter(child: States()),
              ],
            ),
          ),
        );
      },
    );
  }
}
