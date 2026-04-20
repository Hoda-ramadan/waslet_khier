import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/home_feature/data/models/ai_cases_model/ai_cases_model.dart';

class AiCasesRepo {
  final ApiService service;
  AiCasesRepo(this.service);

  Future<List<AiCasesModel>> getAiCases() async {
    try {
      return await service.getAiCases();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
