import 'package:waslet_khier/features/home_feature/data/models/ai_cases_model/ai_cases_model.dart';

abstract class AiCasesState {}

class AiCasesInitial extends AiCasesState {}

class AiCasesLoading extends AiCasesState {}

class AiCasesSuccess extends AiCasesState {
  final List<AiCasesModel> cases;
  AiCasesSuccess(this.cases);
}

class AiCasesFailure extends AiCasesState {
  final String error;
  AiCasesFailure(this.error);
}
