import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categorycubit.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/categoryrepo.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/categoryviewbody.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class Categoryview extends StatelessWidget {
  const Categoryview({
    super.key,
    required this.categoryId,
    required this.categoryMadel,
  });
  final int categoryId;
  final CategoryMadel categoryMadel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: backGroundColor,
      body: BlocProvider(
        create: (context) {
          return Categorycubit(Categoryrepo(ApiService(Dio())))
            ..getCategoriesByCharity(categoryId);
        },
        child: CategoryView_body(
          categoryId: categoryId,
          categoryMadel: categoryMadel,
        ),
      ),
    );
  }
}
