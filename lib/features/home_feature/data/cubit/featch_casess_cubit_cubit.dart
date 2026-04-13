import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/home_feature/data/repo/home_repo.dart';

part 'featch_casess_cubit_state.dart';

class FeatchCasessCubitCubit extends Cubit<FeatchCasessCubitState> {
  FeatchCasessCubitCubit() : super(FeatchCasessCubitInitial());

  List<CaseModel> states = [];

  Future<void> featchCasess() async {
    emit(FeatchCassCubitLoading());

    try {
      final result = await HomeRepo(ApiService(Dio())).getCasess();

      states = result;
      emit(FeatchCasesCubitSucesses(casee: states));
    } catch (e) {
      emit(FeatchCasesCubitFaild(errorMessage: e.toString()));
    }
  }
}
