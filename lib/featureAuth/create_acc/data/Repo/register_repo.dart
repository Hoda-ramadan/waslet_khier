import 'package:dio/dio.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/Model/donor_register.dart';

class RegisterRepo {
  final ApiService apiService;
  RegisterRepo(this.apiService);

  Future<DonorRegister> registerDonor({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    String? imagePath,
  }) async {
    final Map<String, dynamic> data = {
      'FirstName': firstName,
      'LastName': lastName,
      'Phone': phone,
      'Email': email,
      'Password': password,
      if (imagePath != null && imagePath.isNotEmpty)
        'Image': await MultipartFile.fromFile(imagePath),
    };

    final response = await apiService.postRegister(
      endPoint: '/User/Donor-Register',
      data: data,
      header: null,
      isFormdata: true,
    );

    return DonorRegister.fromJson(response.data);
  }
}
