import 'package:equatable/equatable.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_states_model.dart';
 
abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object?> get props => [];
}
 
class AdminInitial extends AdminState {}
 
class AdminLoading extends AdminState {}
 
class AdminSuccess extends AdminState {
  final AdminStatsModel stats;
  const AdminSuccess(this.stats);
  @override
  List<Object?> get props => [stats];
}
 
class AdminFailure extends AdminState {
  final String error;
  const AdminFailure(this.error);
  @override
  List<Object?> get props => [error];
}
 
class AdminCasesLoading extends AdminState {}
 
class AdminCasesSuccess extends AdminState {
  final List<AdminCaseModel> cases;
  const AdminCasesSuccess({required this.cases});
  @override
  List<Object?> get props => [cases];
}
 
class AdminCasesFailure extends AdminState {
  final String error;
  const AdminCasesFailure(this.error);
  @override
  List<Object?> get props => [error];
}
 
// ─── Create Case States ────────────────────────────────────────────────────────
 
class CreateCaseLoading extends AdminState {}
 
class CreateCaseSuccess extends AdminState {
  final String message;
  const CreateCaseSuccess(this.message);
  @override
  List<Object?> get props => [message];
}
 
class CreateCaseFailure extends AdminState {
  final String error;
  const CreateCaseFailure(this.error);
  @override
  List<Object?> get props => [error];
}