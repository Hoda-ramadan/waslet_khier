import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/data/cubit/featch_casess_cubit_cubit.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states_card.dart';

class StatesCardGridView extends StatelessWidget {
  const StatesCardGridView({super.key});

  // card width fixed at 160
  // image  = 160 * 0.55 = 88
  // content = title(16) + desc(13) + charity(14) + progress(14) + bar(10) + buttons(26) + spacing(20) + padding(8) = 121
  // total = 88 + 121 = 209 → use 220 for safe buffer
  static const double _cardWidth = 160;
  static const double _cardHeight = 220;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _cardHeight,
      child: BlocBuilder<FeatchCasessCubitCubit, FeatchCasessCubitState>(
        builder: (context, state) {
          if (state is FeatchCassCubitLoading) {
            return const Center(
              child: CircularProgressIndicator(color: tintAppColor),
            );
          } else if (state is FeatchCasesCubitSucesses) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.casee.length,
              itemBuilder: (context, index) {
                final item = state.casee[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: SizedBox(
                    width: _cardWidth,
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          '/cases/case_detals_view',
                          extra: state.casee[index],
                        );
                      },
                      child: StatesCard(
                        casee: item,
                        cardWidth: _cardWidth,
                        maxDescLines:
                            1, // ← 1 line only in home horizontal list
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is FeatchCasesCubitFaild) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
