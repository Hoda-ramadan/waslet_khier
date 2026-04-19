import 'package:dio/dio.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';

class ApiService {
  final Dio dio;
  final String baseurl = 'https://erfan333555-001-site1.stempurl.com/api';

  ApiService(this.dio);

  Future<List<CategoryMadel>> getCategoriesByCharity(int charityId) async {
    try {
      final response = await dio.get('categories/charity/$charityId');
      return (response.data as List)
          .map((e) => CategoryMadel.fromJson(e))
          .toList();
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

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timed out');
      case DioExceptionType.badResponse:
        final data = e.response?.data;
        String errorMessage;

        if (data is Map<String, dynamic>) {
          // Server returned JSON like {"message": "..."}
          errorMessage =
              data['message']?.toString() ??
              'Server error: ${e.response?.statusCode}';
        } else if (data is String && data.isNotEmpty) {
          // Server returned a plain string
          errorMessage = data;
        } else {
          errorMessage = 'Server error: ${e.response?.statusCode}';
        }

        return Exception(errorMessage);
      default:
        return Exception('Network error occurred');
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
}
