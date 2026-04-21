import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categorycubit.dart';

import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/categoryrepo.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_details_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class CharityDetelsView extends StatelessWidget {
  const CharityDetelsView({super.key, required this.charity});
  final CharityModel charity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        print("${charity.id}");
        return Categorycubit(Categoryrepo(ApiService(Dio())))
          ..getCategoriesByCharity(charity.id!);
      },

      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: backGroundColor,
        body: SingleChildScrollView(
          child: CharityDetailsView_body(charity: charity),
        ),
      ),
    );
  }
}
