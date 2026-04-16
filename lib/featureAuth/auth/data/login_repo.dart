import 'package:waslet_khier/core/api/auth_services/authService.dart';
import 'package:waslet_khier/featureAuth/auth/data/models/login_model.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authService.login(email: email, password: password);

      return result;
    } catch (e) {
      throw Exception("Login Repository Error: $e");
    }
  }
}
