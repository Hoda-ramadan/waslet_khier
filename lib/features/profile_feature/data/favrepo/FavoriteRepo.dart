import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/profile_feature/data/models/favorite_model/favorite_model.dart';

class Favoriterepo {
  final ApiService apiService;

  Favoriterepo(this.apiService);

  Future<List<FavoriteModel>> getFavoritcase() async {
    var data = await apiService.get(endPoint: '/Charity');
    List favCase = data as List; // API returns a List directly
    return favCase.map((e) => FavoriteModel.fromJson(e)).toList();
  }

  /*Future<List<FavoriteModel>> getfavoritcharity(int id) async {
      var data = await apiService.get(endPoint: '/Charity/$id');
      List  favCharity = data as List; // API returns a List directly
      return  favCharity.map((e) =>  FavoriteModel.fromJson(e)).toList();
    }*/
}
