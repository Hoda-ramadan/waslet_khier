import 'package:dio/dio.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/models/donor_register/donor_register.dart';

class DonorRepo {
  final Dio dio = Dio();

  final String baseUrl = "http://abdoerfann-001-site1.ntempurl.com/api";

  Future<DonorRegister?> registerDonor({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "$baseUrl/User/Donor-Register",
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "phone": phone,
          "email": email,
          "password": password,
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      return DonorRegister.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        return DonorRegister.fromJson(e.response!.data);
      }
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
