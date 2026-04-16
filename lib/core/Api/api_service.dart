import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
  final String baseurl = 'https://erfan333555-001-site1.stempurl.com/api';

  ApiService(this.dio);

  // 🔥 GET (واحدة لكل حاجة)
  Future<dynamic> get({required String endPoint}) async {
    try {
      var response = await dio.get(baseurl + endPoint);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 🔥 POST
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
        return Exception(
          e.response?.data['message'] ??
              'Server error: ${e.response?.statusCode}',
        );
      default:
        return Exception('Network error occurred');
    }
  }
}