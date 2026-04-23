
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';


class AiCasesRepo {
  final ApiService service;
  AiCasesRepo(this.service);

  Future<List<CaseModel>> getAiCases() async {
    try {
      return await service.getAiCases();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
