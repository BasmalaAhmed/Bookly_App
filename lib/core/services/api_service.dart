import 'package:dio/dio.dart';

class ApiService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/';
  final Dio _dio;

  ApiService(this._dio){
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  Future<Map<String, dynamic>> fetchBooks({required String endpoint}) async {
    final response = await _dio.get(
      "$_baseUrl$endpoint",
    );

    return response.data;
  }
}

