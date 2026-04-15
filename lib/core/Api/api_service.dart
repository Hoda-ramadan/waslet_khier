import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
  final String baseurl = 'https://erfan333555-001-site1.stempurl.com/api';
  ApiService(this.dio);

  Future<dynamic> getRegister({required String endPoint}) async {
    var response = await dio.get(baseurl + endPoint);
    return response.data;
  }

  Future<dynamic> getCasess({required String endPoint}) async {
    var response = await dio.get(baseurl + endPoint);
    return response.data;
  }

  Future<dynamic> getCharites({required String endPount}) async {
    var response = await dio.get(baseurl + endPount);
    return response.data;
  }
}
