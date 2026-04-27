import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/update_charity_detals_states.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/charity_repo.dart';



class EditCharityCubit extends Cubit<EditCharityState> {
  final CharityRepo repo;

  EditCharityCubit(this.repo) : super(EditCharityInitial());

  Future<void> updateCharity({
  required int charityId,
  required FormData formData, // ✅ was Map<String, dynamic> data
}) async {
  emit(EditCharityLoading());
  try {
    await repo.updateCharity(charityId: charityId, formData: formData);
    emit(EditCharitySuccess());
  } catch (e) {
    emit(EditCharityFailure(e.toString()));
  }
}
}