import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/models/change_pass_model.dart';

class ResetpasswordRepo {
  final ApiService apiService;

  ResetpasswordRepo(this.apiService);

  Future<String> sendEmail({required String email}) async {
    final response = await apiService.post(
      endPoint: '/User/ForgetPassword',
      data: '"$email"', // ✅ بعتي الـ email كـ JSON string بـ quotes
      headers: {'Content-Type': 'application/json'},
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return data['message'] ?? 'تم الإرسال';
    }
    return 'تم الإرسال';
  }

  Future<String> verifyCode({
    required String code,
    required String email, // ✅ ضيفي email
  }) async {
    final response = await apiService.post(
      endPoint: '/User/CheckCode',
      data: {'code': code, 'email': email}, // ✅ بعتي الاتنين
      headers: {'Content-Type': 'application/json'},
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return data['token'] ?? '';
    }
    return '';
  }

  Future<String> changePassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
    required String email,
    required String code,
  }) async {
    final response = await apiService.post(
      endPoint: '/User/ResetPassword',
      data: {
        'NewPassword': newPassword,
        'ConfirmPassword': confirmPassword,
        'Token': token,
        'Email': email,
        'Code': code,
      },
      headers: {'Content-Type': 'application/json'},
    );

    // ✅ الـ API بيرجع String مباشرةً
    final data = response.data;
    if (data is String) return data;
    if (data is Map<String, dynamic>) return data['message'] ?? 'تم التغيير';
    return 'تم التغيير';
  }
}
