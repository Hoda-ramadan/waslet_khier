import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/core/routing/routing_class.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordcubit.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/repo/forgetpasswordRepo.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_cubit.dart';
import 'package:waslet_khier/features/home_feature/data/cubit/featch_casess_cubit_cubit.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: appcolor,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const WasletKhier());
}

class WasletKhier extends StatelessWidget {
  const WasletKhier({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeatchCasessCubitCubit()..featchCasess(),
        ),
        BlocProvider(create: (context) => CharityCubit()..getCharites()),
        BlocProvider(
          create: (context) =>
              ResetpasswordCubit(ResetpasswordRepo(ApiService(Dio()))),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
