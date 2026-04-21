import 'dart:typed_data';
 
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
 
  /// POST /Case — multipart/form-data, works on web + mobile.
  Future<String> createCase({
    required CreateCaseRequestModel request,
    // Mobile
    String? coverImagePath,
    List<String> attachmentPaths = const [],
    // Web
    Uint8List? coverImageBytes,
    String? coverImageName,
    List<Uint8List> attachmentBytes = const [],
    List<String> attachmentNames = const [],
  }) async {
    final formData = FormData();
 
    // ── Text fields ──────────────────────────────────────────────────────────
    request.toFormFields().forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });
 
    // ── Cover image ──────────────────────────────────────────────────────────
    if (coverImageBytes != null && coverImageName != null) {
      formData.files.add(MapEntry(
        'CoverImageFile',
        MultipartFile.fromBytes(coverImageBytes, filename: coverImageName),
      ));
    } else if (coverImagePath != null) {
      formData.files.add(MapEntry(
        'CoverImageFile',
        await MultipartFile.fromFile(
          coverImagePath,
          filename: coverImagePath.split('/').last,
        ),
      ));
    }
 
    // ── Attachment files ─────────────────────────────────────────────────────
    if (attachmentBytes.isNotEmpty) {
      for (int i = 0; i < attachmentBytes.length; i++) {
        formData.files.add(MapEntry(
          'AttachmentFiles',
          MultipartFile.fromBytes(
            attachmentBytes[i],
            filename: i < attachmentNames.length
                ? attachmentNames[i]
                : 'file_$i',
          ),
        ));
      }
    } else {
      for (final path in attachmentPaths) {
        formData.files.add(MapEntry(
          'AttachmentFiles',
          await MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          ),
        ));
      }
    }
 
    // ── DEBUG — remove after fixing ──────────────────────────────────────────
    print('🟡 POST to: ${apiService.baseurl}/Case');
    print('🟡 FIELDS:');
    for (final f in formData.fields) {
      print('   ${f.key} = ${f.value}');
    }
    print('🟡 FILES:');
    for (final f in formData.files) {
      print('   ${f.key} = ${f.value.filename}');
    }
    // ────────────────────────────────────────────────────────────────────────
 
    try {
      final response = await apiService.dio.post<dynamic>(
        '${apiService.baseurl}/Case',
        data: formData,
      );
 
      print('🟢 RESPONSE STATUS: ${response.statusCode}');
      print('🟢 RESPONSE BODY: ${response.data}');
 
      final body = response.data;
      if (body is Map<String, dynamic>) {
        return body['message'] as String? ?? 'تم إنشاء الحالة بنجاح';
      }
      return 'تم إنشاء الحالة بنجاح';
 
    } on DioException catch (e) {
      print('🔴 ERROR STATUS: ${e.response?.statusCode}');
      print('🔴 ERROR BODY: ${e.response?.data}');
      rethrow;
    }
  }
}