import 'package:bloc/bloc.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordstates.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/repo/forgetpasswordRepo.dart';

class ResetpasswordCubit extends Cubit<ForgetPasswordState> {
  final ResetpasswordRepo repo;
  String verifyToken = '';
  String savedEmail = ''; // ✅ احفظي الإيميل هنا

  ResetpasswordCubit(this.repo) : super(ForgetPasswordInitial());

  Future<void> sendEmail(String email) async {
    emit(ForgetPasswordLoading());
    try {
      savedEmail = email; // ✅ احفظي الإيميل
      final result = await repo.sendEmail(email: email);
      emit(ForgetPasswordSuccess(result));
    } catch (e) {
      emit(ForgetPasswordFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> verifyCode(String code) async {
    emit(VerifyCodeLoading());
    try {
      final token = await repo.verifyCode(
        code: code,
        email: savedEmail,
      ); // ✅ بعتي الإيميل
      verifyToken = token;
      emit(VerifyCodeSuccess(token));
    } catch (e) {
      emit(VerifyCodeFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> changePassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());
    try {
      final model = await repo.changePassword(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        token: verifyToken,
      );
      emit(ChangePasswordSuccess(model.message));
    } catch (e) {
      emit(ChangePasswordFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
