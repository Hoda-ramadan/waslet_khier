import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';
import 'package:waslet_khier/features/home_feature/data/models/ai_cases_model/ai_cases_model.dart';

class ApiService {
  final Dio dio;
  final String baseurl = 'https://erfan333555-001-site1.stempurl.com/api';

  ApiService(this.dio);

  Future<List<CategoryMadel>> getCategoriesByCharity(int charityId) async {
    try {
      final response = await dio.get('$baseurl/categories/charity/$charityId');
      return (response.data as List)
          .map((e) => CategoryMadel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<CaseModel>> getAiCases() async {
    try {
      final response = await dio.get('$baseurl/Case/featured');
      if (response.data is List) {
        return (response.data as List)
            .map((e) => CaseModel.fromJson(e))
            .toList();
      } else {
        print(' Response is not a List: ${response.data}');
        return [];
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<dynamic> get({required String endPoint}) async {
    try {
      var response = await dio.get(baseurl + endPoint);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> postRegister({
    required String endPoint,
    dynamic data,
    required Map<String, dynamic>? header,
    bool isFormdata = false,
  }) async {
    try {
      var response = await dio.post(
        baseurl + endPoint,
        data: isFormdata ? FormData.fromMap(data) : data,
        options: Options(headers: header),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> postLogin({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dio.post(
        baseurl + endPoint,
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      var response = await dio.post(
        baseurl + endPoint,
        data: isFormData ? FormData.fromMap(data) : data,
        options: Options(
          headers: headers ?? {'Content-Type': 'application/json'},
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> softDeleteCase(int caseId) async {
    try {
      await dio.patch('$baseurl/Case/$caseId/soft-delete');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT /Case/{id} — multipart/form-data
  Future<String> editCase({
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
    final fields = {
      'Title': title,
      'Description': description,
      'BeneficiaryName': beneficiaryName,
      'Age': age.toString(),
      'TargetAmount': targetAmount.toString(),
      'CategoryId': categoryId.toString(),
      'Priority': priority,
      'Status': status,
      'CharityId': charityId.toString(),
      'AdminId': adminId.toString(),
      'IsFeatured': isFeatured.toString(),
      if (location != null) 'Location': location,
      if (endDate != null) 'EndDate': endDate,
    };
    fields.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    // ── Cover image ──────────────────────────────────────────────────────────
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

    // ── Attachments ──────────────────────────────────────────────────────────
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
      final response = await dio.put<dynamic>(
        '$baseurl/Case/$caseId',
        data: formData,
      );
      final body = response.data;
      if (body is Map<String, dynamic>) {
        return body['message'] as String? ?? 'تم تعديل الحالة بنجاح';
      }
      return 'تم تعديل الحالة بنجاح';
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<dynamic> getWithToken({
    required String endPoint,
    required String token,
  }) async {
    try {
      var response = await dio.get(
        baseurl + endPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timed out');
      case DioExceptionType.badResponse:
        final data = e.response?.data;
        print("full error ${data}");
        print("state code ${e.response?.statusCode}");
        String errorMessage;
        if (data is Map<String, dynamic>) {
          errorMessage =
              data['message']?.toString() ??
              'Server error: ${e.response?.statusCode}';
        } else if (data is String && data.isNotEmpty) {
          errorMessage = data;
        } else {
          errorMessage = 'Server error: ${e.response?.statusCode}';
        }
        return Exception(errorMessage);
      default:
        return Exception('Network error occurred');
    }
  }
}
