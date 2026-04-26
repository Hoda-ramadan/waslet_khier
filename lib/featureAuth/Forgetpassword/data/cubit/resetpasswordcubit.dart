import 'package:bloc/bloc.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordstates.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/repo/forgetpasswordRepo.dart';

class ResetpasswordCubit extends Cubit<ForgetPasswordState> {
  final ResetpasswordRepo repo;
  String verifyToken = '';
  String savedEmail = ''; // ✅ ضيفي
  String savedCode = ''; // ✅ ضيفي

  ResetpasswordCubit(this.repo) : super(ForgetPasswordInitial());

  Future<void> sendEmail(String email) async {
    emit(ForgetPasswordLoading());
    try {
      savedEmail = email; // ✅ احفظي
      final result = await repo.sendEmail(email: email);
      emit(ForgetPasswordSuccess(result));
    } catch (e) {
      emit(ForgetPasswordFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> verifyCode(String code) async {
    emit(VerifyCodeLoading());
    try {
      savedCode = code; // ✅ احفظي
      final token = await repo.verifyCode(code: code, email: savedEmail);
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
      final message = await repo.changePassword(
        // ✅ String مش Model
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        token: verifyToken,
        email: savedEmail,
        code: savedCode,
      );
      emit(ChangePasswordSuccess(message));
    } catch (e) {
      emit(ChangePasswordFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
