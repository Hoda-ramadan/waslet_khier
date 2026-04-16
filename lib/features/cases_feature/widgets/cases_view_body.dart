import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/data/cubit/featch_casess_cubit_cubit.dart';

import 'package:waslet_khier/features/home_feature/data/models/state_model.dart';

import 'package:waslet_khier/features/home_feature/views/widgets/states_card.dart';

class CasesViewBody extends StatelessWidget {
  const CasesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<FeatchCasessCubitCubit, FeatchCasessCubitState>(
        builder: (context, state) {
          if (state is FeatchCassCubitLoading) {
            return Center(
              child: CircularProgressIndicator(value: 24, color: tintAppColor),
            );
          }
          if (state is FeatchCasesCubitSucesses) {
            return GridView.builder(
              itemCount: state.casee.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.74,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.push(
                      '/cases/case_detals_view',
                      extra: state.casee[index],
                    );
                  },
                  child: StatesCard(casee: state.casee[index]),
                );
              },
            );
          }
          if (state is FeatchCasesCubitFaild) {
            return Center(
              child: Text(
                state.errorMessage.toString(),
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            );
          } else {
            return Center(child: Text('UnExpected error'));
          }
        },
      ),
    );
  }
}
