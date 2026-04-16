import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/Model/donor_register.dart';

class RegisterRepo {
  final ApiService apiService;

  RegisterRepo(this.apiService);

  Future<DonorRegister> register({required Map<String, dynamic> data}) async {
    final response = await apiService.postRegister(
      endPoint: '/User/Donor-Register',
      data: data,
    );

    return DonorRegister.fromJson(response.data);
  }
}
