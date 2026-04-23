import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/profile_feature/data/models/favorite_model/favorite_model.dart';

class Favoriterepo {
  final ApiService apiService;

  Favoriterepo(this.apiService);

  // ✅ FIXED: كانت بتكال /Charity - دلوقتي الـ endpoint الصح
  Future<List<FavoriteModel>> getFavoritcase(int donorId) async {
    var data = await apiService.get(endPoint: '/FavoriteCase/donor/$donorId');
    List favCase = data as List;
    return favCase.map((e) => FavoriteModel.fromJson(e)).toList();
  }

  // ✅ NEW: أضف حالة للمفضلة
  Future<void> addFavoriteCase({
    required int donorId,
    required int caseId,
  }) async {
    await apiService.post(
      endPoint: '/FavoriteCase',
      data: {'donorId': donorId, 'caseId': caseId},
    );
  }

  // ✅ NEW: احذف حالة من المفضلة
  Future<void> removeFavoriteCase({
    required int donorId,
    required int caseId,
  }) async {
    await apiService.get(endPoint: '/FavoriteCase/donor/$donorId/case/$caseId');
  }
}
