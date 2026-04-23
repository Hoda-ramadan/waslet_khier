import 'dart:typed_data';
 
import 'package:bloc/bloc.dart';
import 'package:waslet_khier/features/admin_feature/data/create_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/create_case_request_model.dart';
import '../repo/admin_repo.dart';
import 'admin_states.dart';
 
class AdminCubit extends Cubit<AdminState> {
  final AdminRepo repo;
  final int charityId;
 
  AdminCubit(this.repo, {required this.charityId}) : super(AdminInitial());
 
  Future<void> loadDashboard() async {
    emit(AdminLoading());
    try {
      final stats = await repo.getDashboardStats(charityId);
      emit(AdminSuccess(stats));
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }
 void removeCaseById(int caseId) {
  final current = state;
  if (current is AdminCasesSuccess) {
    final updated = current.cases
        .where((c) => c.id != caseId)
        .toList();
    emit(AdminCasesSuccess(cases: updated));
  }
}
  Future<void> loadCases(int charityId) async {
    emit(AdminCasesLoading());
    try {
      final cases = await repo.getCharityCases(charityId);
      emit(AdminCasesSuccess(cases: cases));
    } catch (e) {
      emit(AdminCasesFailure(e.toString()));
    }
  }
 
  Future<void> createCase({
    required CreateCaseRequestModel request,
    // Mobile
    String? coverImagePath,
    List<String> attachmentPaths = const [],
    // Web
    Uint8List? coverImageBytes,
    String? coverImageName,
    List<Uint8List> attachmentBytes = const [],
    List<String> attachmentNames = const [],
  }) async {
    emit(CreateCaseLoading());
    try {
      final message = await repo.createCase(
        request:          request,
        coverImagePath:   coverImagePath,
        attachmentPaths:  attachmentPaths,
        coverImageBytes:  coverImageBytes,
        coverImageName:   coverImageName,
        attachmentBytes:  attachmentBytes,
        attachmentNames:  attachmentNames,
      );
      emit(CreateCaseSuccess(message));
      await loadDashboard();
    } catch (e) {
      emit(CreateCaseFailure(e.toString()));
    }
  }
}