import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';

class CharityRepo {
  final ApiService apiService;

  CharityRepo(this.apiService);

  Future<List<CharityModel>> getCharites() async {
    var data = await apiService.getCharites(endPount: '/Charity');
    List charites = data as List; // API returns a List directly
    return charites.map((e) => CharityModel.fromJson(e)).toList();
  }

  Future<List<CharityModel>> users()async{
    var data = await apiService.getCharites(endPount: '/Charity');
    List charites = data as List; // API returns a List directly
    return charites.map((e) => CharityModel.fromJson(e)).toList();
  }
}
