import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/Model/donor_register.dart';

class RegisterRepo {
  final ApiService apiService;

  RegisterRepo(this.apiService);

  Future<DonorRegister> postregister() async {
    var data = await apiService.postRegister(endPoint: '/User/Donor-Register');

    return DonorRegister.fromJson(data);
  }
}
