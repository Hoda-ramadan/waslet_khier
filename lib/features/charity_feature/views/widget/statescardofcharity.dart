import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customstatecard.dart';
import 'package:waslet_khier/features/home_feature/data/cubit/featch_casess_cubit_cubit.dart';

class StatesCardGridViewOfcharity extends StatelessWidget {
  StatesCardGridViewOfcharity({super.key, required this.charityModel});
  final CharityModel charityModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: SizedBox(
        width: 160,
        child: CasesViewBody_Charity(charityModel: charityModel),
      ),
    );
  }
}

class CasesViewBody_Charity extends StatelessWidget {
  const CasesViewBody_Charity({super.key, required this.charityModel});
  final CharityModel charityModel;
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
            final filteredCases = state.casee
                .where((c) => c.charityId == charityModel.id)
                .toList();
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredCases.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 160,
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          '/cases/case_detals_view',
                          extra: state.casee[index],
                        );
                      },
                      child: Customstatecard(casee: state.casee[index]),
                    ),
                  ),
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
