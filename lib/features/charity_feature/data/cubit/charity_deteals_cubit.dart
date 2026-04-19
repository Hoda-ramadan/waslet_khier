import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/charity_repo.dart';
part 'charity_state.dart';

class CharityDetealsCubit extends Cubit<CharityState> {
  final CharityRepo repo;
  List<CharityModel> _cachedCharities = [];

  CharityDetealsCubit(this.repo) : super(CharityInitial());

  Future<void> getCharityById(int id) async {
    emit(CharityDetailsLoading());
    try {
      final charity = await repo.getCharityById(id);
      emit(CharityDetailsSuccess(charity));
    } catch (e) {
      emit(CharityDetailsFaild(e.toString()));
    }
  }
}
