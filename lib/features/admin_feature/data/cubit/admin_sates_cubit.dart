import 'package:bloc/bloc.dart';
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
}