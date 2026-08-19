import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, void>> addFavorite(BookModel book);
  Future<Either<Failure, void>> removeFavorite(String bookId);
  Future<Either<Failure, List<BookModel>>> fetchFavorites();
  Future<Either<Failure, bool>> isFavorite(String bookId);
  Future<void> deleteAllFavorites();
}
