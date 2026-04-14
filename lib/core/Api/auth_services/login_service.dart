import 'package:dio/dio.dart';
import 'package:waslet_khier/featureAuth/auth/data/models/login_model.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/login",
        data: {"email": email, "password": password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final data = response.data;

      return LoginModel.fromJson(
        data is Map<String, dynamic> ? data : Map<String, dynamic>.from(data),
      );
    } catch (e) {
      throw Exception("Login Error: $e");
    }
  }
}
