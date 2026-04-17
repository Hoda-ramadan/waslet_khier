import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_model.dart';

class Categoryrepo {
  final ApiService apiService;

  Categoryrepo(this.apiService);

  Future<List<CategoryModel>> getCategory() async {
    var data = await apiService.get(endPoint: '/Category');
    List category = data;
    return category.map((e) => CategoryModel.fromJson(e)).toList();
  }

  Future<CategoryModel> getCategoryById(int id) async {
    var data = await apiService.get(endPoint: '/Category/$id');

    return CategoryModel.fromJson(data);
  }
}
