import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/cubits/registercubit.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/repo.dart';
import 'package:waslet_khier/featureAuth/create_acc/widget/create_acc_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class CreateAccView extends StatelessWidget {
  const CreateAccView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocProvider(
        create: (context) => RegisterCubit(DonorRepo()),
        child: RegisterView(),
      ),
      backgroundColor: backGroundColor,
    );
  }
}
