import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';

class CharityRepo {
  final ApiService apiService;

  CharityRepo(this.apiService);

  Future<List<CharityModel>> getCharites() async {
    var data = await apiService.get(endPoint: '/Charity');
    List charites = data as List; // API returns a List directly
    return charites.map((e) => CharityModel.fromJson(e)).toList();
  }

  Future<CharityModel> getCharityById(int id) async {
    var data = await apiService.get(endPoint: '/Charity/$id');

    return CharityModel.fromJson(data);
  }
}
