import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/Model/donor_register.dart';

class RegisterRepo {
  final ApiService apiService;

  RegisterRepo(this.apiService);

  Future<DonorRegister> getregister() async {
    var data = await apiService.getRegister(endPoint: '/User/Donor-Register');

    return DonorRegister.fromJson(data);
  }
}
