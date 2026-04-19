import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return const CircularProgressIndicator();
        } else if (state is CategorySuccess) {
          return SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return SectionsOfCharity(
                  categoryModel: state.categories[index],
                );
              },
            ),
          );
        } else if (state is CategoryFailed) {
          return Text(state.errorMsg);
        }
        return const SizedBox();
      },
    );
  }
}
