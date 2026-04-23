import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categorycubit.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_deteals_cubit.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/categoryrepo.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/charity_repo.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_details_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
 
class CharityDetelsView extends StatefulWidget {
  const CharityDetelsView({super.key, required this.charity});
  final CharityModel charity;

  @override
  State<CharityDetelsView> createState() => _CharityDetelsViewState();
}

class _CharityDetelsViewState extends State<CharityDetelsView> {
  late final CharityDetealsCubit _detealsCubit;

  @override
  void initState() {
    super.initState();
    _detealsCubit = CharityDetealsCubit(CharityRepo(ApiService(Dio())));
    _detealsCubit.getCharityById(widget.charity.id!);
  }

  @override
  void dispose() {
    _detealsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _detealsCubit),
        BlocProvider(
          create: (_) => Categorycubit(Categoryrepo(ApiService(Dio())))
            ..getCategoriesByCharity(widget.charity.id ?? 0),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: backGroundColor,
        body: BlocBuilder<CharityDetealsCubit, CharityState>(
          builder: (context, state) {
            if (state is CharityDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: tintAppColor),
              );
            }
            if (state is CharityDetailsSuccess) {
              return SingleChildScrollView(
                child: CharityDetailsView_body(charity: state.charity),
              );
            }
            if (state is CharityDetailsFaild) {
              return Center(child: Text(state.error));
            }
            return SingleChildScrollView(
              child: CharityDetailsView_body(charity: widget.charity),
            );
          },
        ),
      ),
    );
  }
}