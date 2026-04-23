import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categoryState.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categorycubit.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';

class cstomItem extends StatelessWidget {
  const cstomItem({super.key, required this.category});
  final CategoryMadel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, top: 10),
      height: 82,
      decoration: BoxDecoration(
        border: Border.all(color: tintAppColor),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.category, color: appcolor),
              Text(
                category.name ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: appcolor,
                ),
              ),
            ],
          ),
          Text(
            category.charityName ?? "",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
