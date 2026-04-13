import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/features/home_feature/data/cubit/featch_casess_cubit_cubit.dart';


import 'package:waslet_khier/features/home_feature/views/widgets/states_card.dart';

class StatesCardGridView extends StatelessWidget {
  const StatesCardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: BlocBuilder<FeatchCasessCubitCubit, FeatchCasessCubitState>(
        builder: (context, state) {
          if (state is FeatchCassCubitLoading) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (state is FeatchCasesCubitSucesses) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.casee.length,
              itemBuilder: (context, index) {
                final stateModel = state.casee[index];

                return Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: SizedBox(
                    width: 163,
                    child: GestureDetector(
                      onTap: () {
                        context.push('/home/case_detals_view');
                      },
                      child: StatesCard(casee: stateModel),
                    ),
                  ),
                );
              },
            );
          } 
          else if (state is FeatchCasesCubitFaild) {
            return Center(child: Text(state.errorMessage));
          } 
          else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}