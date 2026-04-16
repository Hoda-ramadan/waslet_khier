import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categoryState.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categorycubit.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/bulidRow.dart';

class CustomSections extends StatelessWidget {
  const CustomSections({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Categorycubit, Categorystate>(
      builder: (context, state) {
        if (state is loadingCategory) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessCategory) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CategoriesRow(categories: state.categorymodel, startIndex: 0),
                const SizedBox(height: 15),
                CategoriesRow(categories: state.categorymodel, startIndex: 3),
              ],
            ),
          );
        } else if (state is FaildCategory) {
          return Center(child: Text(state.errormsg));
        } else {
          return const Center(
            child: Text(
              'There was an error',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
      },
    );
  }
}
