import 'package:dio/dio.dart';
import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_states_model.dart';
import 'package:waslet_khier/features/admin_feature/data/create_case_model.dart';
 
class AdminRepo {
  final ApiService apiService;
  AdminRepo(this.apiService);
 
  Future<AdminStatsModel> getDashboardStats(int charityId) async {
    final charity =
        await apiService.get(endPoint: '/Charity/$charityId')
            as Map<String, dynamic>;
    return AdminStatsModel(
      id: charity['id'] ?? 0,
      charityName: charity['name'] ?? '',
      charityLogo: charity['logoUrl'],
      charityEmail: charity['email'],
      charityPhone: charity['phoneNumber'],
      charityAddress: charity['address'],
      totalDonations: (charity['totalRaisedAmount'] as num?)?.toInt() ?? 0,
      totalDonors: (charity['totalDonorsCount'] as num?)?.toInt() ?? 0,
      activeCases: (charity['totalProjectsCount'] as num?)?.toInt() ?? 0,
      completedCases: 0,
      isActive: charity['isActive'] ?? false,
    );
  }
 
  Future<List<AdminCaseModel>> getCharityCases(int charityId) async {
    final response =
        await apiService.get(endPoint: '/Case/charity/$charityId')
            as List<dynamic>;
    return response
        .map((e) => AdminCaseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
 
  /// POST /Case  – multipart/form-data to match the Postman request.
  Future<String> createCase({
    required CreateCaseRequestModel request,
    String? coverImagePath,           // local file path (from image_picker)
    List<String> attachmentPaths = const [],
  }) async {
    final formData = FormData();
 
    // ── Text fields ──────────────────────────────────────────────
    request.toFormFields().forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });
 
    // ── Cover image ──────────────────────────────────────────────
    if (coverImagePath != null) {
      formData.files.add(
        MapEntry(
          'CoverImageFile',
          await MultipartFile.fromFile(
            coverImagePath,
            filename: coverImagePath.split('/').last,
          ),
        ),
      );
    }
 
    // ── Attachment files ─────────────────────────────────────────
    for (final path in attachmentPaths) {
      formData.files.add(
        MapEntry(
          'AttachmentFiles',
          await MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          ),
        ),
      );
    }
 
    // Use Dio directly for multipart — bypass ApiService.post() if it
    // doesn't support FormData. Replace the baseUrl with your actual URL.
    final dio = Dio(BaseOptions(
      baseUrl: apiService.dio.options.baseUrl, // reuse existing base URL
      headers: {
        ...?apiService.dio.options.headers,    // reuse auth headers etc.
        'Content-Type': 'multipart/form-data',
      },
    ));
 
    final response = await dio.post<Map<String, dynamic>>(
      '/Case',
      data: formData,
    );
 
    final body = response.data;
    return body?['message'] as String? ?? 'تم إنشاء الحالة بنجاح';
  }
}