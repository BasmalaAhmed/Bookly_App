import 'package:bookly_app/core/errors/api_failure.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/services/api_service.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:bookly_app/features/search/data/repos/search_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchRepoImpl implements SearchRepo {
  final ApiService apiService;
  final String? apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];

  SearchRepoImpl(this.apiService);

  Future<Either<ApiFailure, List<BookModel>>> _fetchBooks({
    required String endpoint,
    String? query,
  }) async {
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

      if (query != null && query.isNotEmpty) {
        final searchQuery = query.trim().toLowerCase();
        books.retainWhere((book) {
          return book.title.toLowerCase().contains(searchQuery) ||
              book.author.toLowerCase().contains(searchQuery);
        });
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
  Future<Either<Failure, List<BookModel>>> fetchSearchBooks({
    required String query,
  }) {
    return _fetchBooks(
      endpoint: 'volumes?q=${Uri.encodeQueryComponent(query)}&key=$apiKey',
      query: query,
    );
  }
}
