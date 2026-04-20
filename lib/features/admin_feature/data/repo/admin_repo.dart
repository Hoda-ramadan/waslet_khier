import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_states_model.dart';

class AdminRepo {
  final ApiService apiService;
  AdminRepo(this.apiService);

  Future<AdminStatsModel> getDashboardStats(int charityId) async {
    print('>>> charityId sent to API: $charityId');

    final charity = await apiService.get(endPoint: '/Charity/$charityId')
        as Map<String, dynamic>;

    print('>>> charity raw response: $charity');

    return AdminStatsModel(
      id: charity['id'] ?? 0,                                          // ✅ new
      charityName: charity['name'] ?? '',
      charityLogo: charity['logoUrl'],
      charityEmail: charity['email'],                                   // ✅ new
      charityPhone: charity['phoneNumber'],                             // ✅ new
      charityAddress: charity['address'],                               // ✅ new
      totalDonations: (charity['totalRaisedAmount'] as num?)?.toInt() ?? 0,
      totalDonors: (charity['totalDonorsCount'] as num?)?.toInt() ?? 0,
      activeCases: (charity['totalProjectsCount'] as num?)?.toInt() ?? 0,
      completedCases: 0,
      isActive: charity['isActive'] ?? false,                          // ✅ new
    );
  }
  Future<List<AdminCaseModel>> getCharityCases(int charityId) async {
  final response = await apiService.get(
    endPoint: '/Case/charity/$charityId',
  ) as List<dynamic>;

  return response
      .map((e) => AdminCaseModel.fromJson(e as Map<String, dynamic>))
      .toList();
}
}