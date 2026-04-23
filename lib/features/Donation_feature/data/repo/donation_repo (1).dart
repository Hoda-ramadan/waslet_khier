import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/donation_feature/data/models/donation_model.dart';

class DonationRepo {
  final ApiService apiService;

  DonationRepo(this.apiService);

  // إرسال تبرع جديد
  Future<void> addDonation({
    required int donorId,
    required int caseId,
    required double amount,
  }) async {
    await apiService.post(
      endPoint: '/Donation',
      data: {'donorId': donorId, 'caseId': caseId, 'amount': amount},
    );
  }

  // جلب كل تبرعات الـ donor
  Future<List<DonationModel>> getDonorDonations(int donorId) async {
    final data = await apiService.get(endPoint: '/Donation/donor/$donorId');
    final list = data as List;
    return list.map((e) => DonationModel.fromJson(e)).toList();
  }
}
