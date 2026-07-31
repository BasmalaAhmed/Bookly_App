import 'package:bookly_app/features/home/data/models/book_model.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  final List<BookModel> books;

  FavoriteSuccess(this.books);
}

final class FavoriteFailure extends FavoriteState {
  final String errMessage;

  FavoriteFailure(this.errMessage);
}
