import 'package:dio/dio.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/models/change_pass_model.dart';

class ResetpasswordRepo {
  final ApiService apiService;

  ResetpasswordRepo(this.apiService);

  Future<String> sendEmail({required String email}) async {
    final response = await apiService.post(
      endPoint: '/User/ForgetPassword',
      data: {'email': email},
    );

    return response['message'] ?? 'تم الإرسال';
  }

  Future<String> verifyCode({required String code}) async {
    final response = await apiService.post(
      endPoint: '/User/CheckCode',
      data: {'code': code},
    );

    return response['token'] ?? '';
  }

  Future<ChangePassModel> changePassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    final response = await apiService.post(
      endPoint: '/User/ResetPassword',
      data: {
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
        'token': token,
      },
    );

    return ChangePassModel.fromJson(response as Map<String, dynamic>);
  }
}

extension on Response<dynamic> {
  Future<String>? operator [](String other) {}
}
