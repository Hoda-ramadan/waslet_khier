import 'package:dio/dio.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
 
class CharityRepo {
  final ApiService apiService;
 
  CharityRepo(this.apiService);
 
  Future<List<CharityModel>> getCharites() async {
    var data = await apiService.get(endPoint: '/Charity');
    List charites = data as List;
    return charites.map((e) => CharityModel.fromJson(e)).toList();
  }
 
  Future<CharityModel> getCharityById(int id) async {
    var data = await apiService.get(endPoint: '/Charity/$id');
    return CharityModel.fromJson(data);
  }
 
  // ✅ Calls dio.put directly — no apiService.put needed
  Future<void> updateCharity({
    required int charityId,
    required FormData formData,
  }) async {
    try {
      await apiService.dio.put(
        '${apiService.baseurl}/Charity/$charityId',
        data: formData,
      );
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage;
      if (data is Map<String, dynamic>) {
        errorMessage = data['message']?.toString() ??
            'Server error: ${e.response?.statusCode}';
      } else if (data is String && data.isNotEmpty) {
        errorMessage = data;
      } else {
        errorMessage = 'Server error: ${e.response?.statusCode}';
      }
      throw Exception(errorMessage);
    }
  }
}