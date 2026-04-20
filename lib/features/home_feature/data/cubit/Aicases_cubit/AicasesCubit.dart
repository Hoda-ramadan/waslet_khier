import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/features/home_feature/data/cubit/Aicases_cubit/Aicases_state.dart';
import 'package:waslet_khier/features/home_feature/data/repo/aicasesrepo.dart';

class AiCasesCubit extends Cubit<AiCasesState> {
  final AiCasesRepo repo;
  AiCasesCubit(this.repo) : super(AiCasesInitial());

  Future<void> getAiCases() async {
    emit(AiCasesLoading());
    try {
      final cases = await repo.getAiCases();
      emit(AiCasesSuccess(cases));
    } catch (e) {
      emit(AiCasesFailure(e.toString()));
    }
  }
}
