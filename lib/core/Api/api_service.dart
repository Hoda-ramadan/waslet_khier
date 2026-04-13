
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
 final String baseurl='http://abdoerfann-001-site1.ntempurl.com/api' ; 
  ApiService(this.dio);

 Future<dynamic> get({required String endPoint})async {
    var response = await dio.get(baseurl+endPoint);
    return response.data;
  }
}