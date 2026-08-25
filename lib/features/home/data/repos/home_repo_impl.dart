import 'package:bookly_app/core/errors/api_failure.dart';
import 'package:bookly_app/core/services/api_service.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  final String? apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];

  HomeRepoImpl(this.apiService);

  Future<Either<ApiFailure, List<BookModel>>> _fetchBooks(
    String endpoint,
  ) async {
    try {
      if (apiKey == null || apiKey!.isEmpty) {
        return left(ApiFailure('API key is missing.'));
      }
      final response = await apiService.fetchBooks(endpoint: endpoint);
      final List<BookModel> books = [];

      final items = response['items'] as List? ?? [];

      for (var item in items) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ApiFailure.fromDioException(e));
      }
      return left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, List<BookModel>>> fetchNewestBooks() async {
    return _fetchBooks('volumes?q=computer&orderBy=newest&maxResults=20&key=$apiKey');
  }

  @override
  Future<Either<ApiFailure, List<BookModel>>> fetchFeaturedBooks() async {
    return _fetchBooks('volumes?q=programming&maxResults=20&key=$apiKey');
  }

  @override
  Future<Either<ApiFailure, List<BookModel>>> fetchSimilarBooks({
    required String category,
  }) async {
    return _fetchBooks(
      'volumes?q=${Uri.encodeComponent(category)}&key=$apiKey',
    );
  }
}
