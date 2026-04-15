import 'package:dio/dio.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/models/donor_register/donor_register.dart';

class DonorRepo {
  final Dio dio = Dio();

  final String baseUrl = "http://abdoerfann-001-site1.ntempurl.com/api";

  Future<DonorRegister?> registerDonor({
    required String FirstName,
    required String LastName,
    required String Phone,
    required String Email,
    required String Password,
  }) async {
    try {
      final response = await dio.post(
        "$baseUrl/User/Donor-Register",
        data: {
          "FirstName": FirstName,
          "LastName": LastName,
          "Phone": Phone,
          "Email": Email,
          "Password": Password,
        },
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {"Accept": "application/json"},
        ),
      );

      return DonorRegister.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        // مهم جدًا عشان نشوف شكل الـ error الحقيقي
        print("ERROR RESPONSE: ${e.response!.data}");

        return DonorRegister.fromJson(e.response!.data);
      }

      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }
}
