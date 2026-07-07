import 'package:dio/dio.dart';

class ApiService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> fetchBooks({required String endpoint}) async {
    final response = await _dio.get(
      "$_baseUrl$endpoint",
    );

    return response.data;
  }
}

