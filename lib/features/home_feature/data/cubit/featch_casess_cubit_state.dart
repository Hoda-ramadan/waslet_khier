part of 'featch_casess_cubit_cubit.dart';

sealed class FeatchCasessCubitState extends Equatable {
  const FeatchCasessCubitState();

  @override
  List<Object> get props => [];
}

final class FeatchCasessCubitInitial extends FeatchCasessCubitState {}

final class FeatchCassCubitLoading extends FeatchCasessCubitState {}

final class FeatchCasesCubitSucesses extends FeatchCasessCubitState {
  final List<CaseModel> casee;

  const FeatchCasesCubitSucesses({required this.casee});
}

final class FeatchCasesCubitFaild extends FeatchCasessCubitState {
  final String errorMessage;

  const FeatchCasesCubitFaild({required this.errorMessage});
}
