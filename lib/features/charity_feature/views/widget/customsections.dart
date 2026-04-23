import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categoryState.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categorycubit.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/sections_of_charity.dart';

class CustomSections extends StatelessWidget {
  const CustomSections({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Categorycubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const CircularProgressIndicator(color: tintAppColor);
        } else if (state is CategorySuccess) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: state.categories
                .map((e) => SectionsOfCharity(categoryModel: e))
                .toList(),
          );
        } else if (state is CategoryFailed) {
          return Text(state.errorMsg);
        }
        return const SizedBox();
      },
    );
  }
}
