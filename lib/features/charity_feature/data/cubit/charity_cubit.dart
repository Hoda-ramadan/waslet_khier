import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_deteals_cubit.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/charity_repo.dart';


class CharityCubit extends Cubit<CharityState> {
  final CharityRepo repo;
  List<CharityModel> _cachedCharities = [];

  CharityCubit(this.repo) : super(CharityInitial());

  Future<void> getCharites() async {
    if (_cachedCharities.isNotEmpty) {
      emit(CharitySuccess(charites: _cachedCharities));
      return;
    }

    emit(CharityLodaing());
    try {
      final result = await repo.getCharites();
      _cachedCharities = result;
      emit(CharitySuccess(charites: result));
    } catch (e) {
      emit(CharityFaild(errorMessage: e.toString()));
    }
  }
}