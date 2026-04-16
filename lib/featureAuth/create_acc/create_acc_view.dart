// featureAuth/create_acc/presentation/create_acc_view.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/Repo/register_repo.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/cubits/registerCubit.dart';
import 'package:waslet_khier/featureAuth/create_acc/widget/create_acc_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class CreateAccView extends StatelessWidget {
  const CreateAccView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(RegisterRepo(ApiService(Dio()))),
      child: Scaffold(
        appBar: CustomAppBar(),
        body: const RegisterView(),
        backgroundColor: backGroundColor,
      ),
    );
  }
}
