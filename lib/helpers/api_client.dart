import 'package:dio/dio.dart';  

class ApiClient {  
  final Dio _dio = Dio();  

  ApiClient() {  
    _dio.options.baseUrl = 'https://67535e17f3754fcea7bb8e98.mockapi.io/api/v1/';  
  }  

  Future<Response> get(String path) async {  
    return await _dio.get(path);  
  }  

  Future<Response> post(String path, {dynamic data}) async {  
    return await _dio.post(path, data: data);  
  }  
}