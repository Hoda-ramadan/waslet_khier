import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/featureAuth/auth/data/models/login_response_model.dart';

class LoginRepo {
  final ApiService apiService;
  LoginRepo(this.apiService);

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.postLogin(
      endPoint: '/User/Login',
      data: {'email': email, 'password': password},
    );

    print('>>> RAW LOGIN RESPONSE: ${response.data}'); // 👈 ADD THIS

    return LoginResponse.fromJson(response.data);
  }
}
