import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_states_model.dart';
import 'package:waslet_khier/features/admin_feature/data/create_case_model.dart'
    hide AdminCaseModel;
import 'package:waslet_khier/features/admin_feature/data/create_case_request_model.dart';
import '../../../../core/Api/api_service.dart';

class AdminRepo {
  final ApiService apiService;
  AdminRepo(this.apiService);

  // ── Dashboard ──────────────────────────────────────────────────────────────
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

  // ── Cases list ─────────────────────────────────────────────────────────────
  Future<List<AdminCaseModel>> getCharityCases(int charityId) async {
    final response =
        await apiService.get(endPoint: '/Case/charity/$charityId')
            as List<dynamic>;
    return response
        .map((e) => AdminCaseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Create case — POST /Case ───────────────────────────────────────────────
  Future<String> createCase({
    required CreateCaseRequestModel request,
    // Mobile paths
    String? coverImagePath,
    List<String> attachmentPaths = const [],
    // Web bytes
    Uint8List? coverImageBytes,
    String? coverImageName,
    List<Uint8List> attachmentBytes = const [],
    List<String> attachmentNames = const [],
  }) async {
    final formData = FormData();

    request.toFormFields().forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    if (coverImageBytes != null && coverImageName != null) {
      formData.files.add(
        MapEntry(
          'CoverImageFile',
          MultipartFile.fromBytes(coverImageBytes, filename: coverImageName),
        ),
      );
    } else if (coverImagePath != null) {
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

    if (attachmentBytes.isNotEmpty) {
      for (int i = 0; i < attachmentBytes.length; i++) {
        formData.files.add(
          MapEntry(
            'AttachmentFiles',
            MultipartFile.fromBytes(
              attachmentBytes[i],
              filename: i < attachmentNames.length
                  ? attachmentNames[i]
                  : 'file_$i',
            ),
          ),
        );
      }
    } else {
      for (final path in attachmentPaths) {
        formData.files.add(
          MapEntry(
            'AttachmentFiles',
            await MultipartFile.fromFile(path, filename: path.split('/').last),
          ),
        );
      }
    }

    try {
      final response = await apiService.dio.post<dynamic>(
        '${apiService.baseurl}/Case',
        data: formData,
      );
      final body = response.data;
      if (body is Map<String, dynamic>) {
        return body['message'] as String? ?? 'تم إنشاء الحالة بنجاح';
      }
      return 'تم إنشاء الحالة بنجاح';
    } on DioException catch (e) {
      print('❌ Status: ${e.response?.statusCode}');
  print('❌ Response body: ${e.response?.data}');
      rethrow;
    }
  }

  // ── Edit case — PUT /Case/{id} ─────────────────────────────────────────────
  Future<String> editCase({
    // ← fixed: was "apiService.editCase"
    required int caseId,
    required String title,
    required String description,
    required String beneficiaryName,
    required int age,
    required double targetAmount,
    required int categoryId,
    required String priority,
    required String status,
    required int charityId,
    required int adminId,
    required bool isFeatured,
    String? location,
    String? endDate,
    // Mobile paths
    String? coverImagePath,
    List<String> attachmentPaths = const [],
    // Web bytes
    Uint8List? coverImageBytes,
    String? coverImageName,
    List<Uint8List> attachmentBytes = const [],
    List<String> attachmentNames = const [],
  }) {
    return apiService.editCase(
      caseId: caseId,
      title: title,
      description: description,
      beneficiaryName: beneficiaryName,
      age: age,
      targetAmount: targetAmount,
      categoryId: categoryId,
      priority: priority,
      status: status,
      charityId: charityId,
      adminId: adminId,
      isFeatured: isFeatured,
      location: location,
      endDate: endDate,
      coverImagePath: coverImagePath,
      attachmentPaths: attachmentPaths,
      coverImageBytes: coverImageBytes,
      coverImageName: coverImageName,
      attachmentBytes: attachmentBytes,
      attachmentNames: attachmentNames,
    );
  }
}
