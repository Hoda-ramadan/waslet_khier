import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_states_model.dart';


class AdminRepo {
  final ApiService apiService;
  AdminRepo(this.apiService);

  Future<AdminStatsModel> getDashboardStats(int charityId) async {
      print('>>> charityId sent to API: $charityId'); // 👈
    final results = await Future.wait([
      apiService.get(endPoint: '/Charity/$charityId'),
      apiService.get(endPoint: '/Case/get_All_case_By_CharityId/$charityId'),
    ]);
      print('>>> charity raw response: ${results[0]}');
        print('>>> cases raw response: ${results[1]}');
    final charity = results[0] as Map<String, dynamic>;
    final List cases = results[1] as List;

    final activeCases = cases.where((c) => c['isActive'] == true).length;
    final completedCases = cases.where((c) => c['isActive'] == false).length;

    return AdminStatsModel(
      charityName: charity['name'] ?? '',
      charityLogo: charity['logoUrl'],
      totalDonations: (charity['totalRaisedAmount'] as num?)?.toInt() ?? 0,
      totalDonors: (charity['totalDonorsCount'] as num?)?.toInt() ?? 0,
      activeCases: activeCases,
      completedCases: completedCases,
    );
  }
}