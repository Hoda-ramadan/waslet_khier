import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/featureAuth/auth/data/cubit/states.dart';
import 'package:waslet_khier/featureAuth/auth/data/login_response_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  LoginCubit(this.loginRepo) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final result = await loginRepo.login(email: email, password: password);

      if (result.isAuthenticated == true) {
        emit(LoginSuccess(result));
      } else {
        emit(LoginFailure(result.message ?? 'فشل تسجيل الدخول، حاول مرة أخرى'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
