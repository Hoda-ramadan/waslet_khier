import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/featureAuth/auth/data/cubit/states.dart';
import 'package:waslet_khier/featureAuth/auth/data/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repo;

  LoginCubit(this.repo) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final result = await repo.login(email: email, password: password);

      // ممكن تتحققي كمان من isAuthenticated لو موجودة
      if (result.token != null && result.isAuthenticated == true) {
        emit(LoginSuccess(result));
      } else {
        emit(LoginFailure(result.message ?? "Login failed"));
      }
    } catch (e) {
      emit(LoginFailure(_handleError(e)));
    }
  }

  String _handleError(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return "No Internet Connection";
    } else if (error.toString().contains('TimeoutException')) {
      return "Request Timeout";
    } else {
      return "Something went wrong";
    }
  }
}
