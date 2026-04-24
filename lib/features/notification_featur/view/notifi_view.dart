import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/notification_featur/data/cubit/notifi_cubit.dart';
import 'package:waslet_khier/features/notification_featur/data/repo/notifi_repo.dart';
import 'package:waslet_khier/features/notification_featur/view/notifi_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationCubit(NotificationRepo(ApiService(Dio()))),
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: CustomAppBar(),
        body: const NotificationViewBody(),
      ),
    );
  }
}
