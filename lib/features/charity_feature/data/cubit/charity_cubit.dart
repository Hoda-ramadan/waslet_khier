import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/charity_repo.dart';
part 'charity_state.dart';

class CharityCubit extends Cubit<CharityState> {
  CharityCubit() : super(CharityInitial());
  List<CharityModel> charites = [];
  Future<void> getCharites() async {
    emit(CharityLodaing());
    try {
      var data = await CharityRepo(ApiService(Dio())).getCharites();
      charites = data;
      emit(CharitySuccess(charites: charites));
    } catch (e) {
      emit(CharityFaild(errorMessage: e.toString()));
    }
  }

  Future<void> getCharityById(int id) async {
    emit(CharityDetailsLoading());

    try {
      final charity = await CharityRepo(ApiService(Dio())).getCharityById(id);
      emit(CharityDetailsSuccess(charity));
    } catch (e) {
      emit(CharityDetailsFaild(e.toString()));
    }
  }
}
