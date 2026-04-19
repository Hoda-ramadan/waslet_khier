import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/core/api/api_service.dart' hide ApiService;
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';

class Categoryrepo {
  final ApiService apiService;

  Categoryrepo(this.apiService);

  Future<List<CategoryMadel>> getCategory() async {
    var data = await apiService.get(endPoint: '/Category');
    List category = data;
    return category.map((e) => CategoryMadel.fromJson(e)).toList();
  }

  Future<CategoryMadel> getCategoryById(int id) async {
    var data = await apiService.get(endPoint: '/Category/$id');

    return CategoryMadel.fromJson(data);
  }

  Future<List<CategoryMadel>> getCategoriesByCharity(int charityId) async {
    var data = await apiService.get(endPoint: "/Category");
    print("data type: ${data.runtimeType}");
    print("data: $data");
    List category = data as List;
    return category.map((e) => CategoryMadel.fromJson(e)).toList();
  }
}
