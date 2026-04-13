import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';

class HomeRepo {
  final ApiService apiService;

  HomeRepo(this.apiService);

 Future<List<CaseModel>> getCasess() async {
  var data = await apiService.get(endPoint: '/Case');
  List casess = data as List; // API returns a List directly
  return casess.map((e) => CaseModel.fromJson(e)).toList();
}
} 