import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/home_feature/data/models/ai_cases_model/ai_cases_model.dart';

abstract class AiCasesState {}

class AiCasesInitial extends AiCasesState {}

class AiCasesLoading extends AiCasesState {}

class AiCasesSuccess extends AiCasesState {
  final List<CaseModel> cases;
  AiCasesSuccess(this.cases);
}

class AiCasesFailure extends AiCasesState {
  final String error;
  AiCasesFailure(this.error);
}
