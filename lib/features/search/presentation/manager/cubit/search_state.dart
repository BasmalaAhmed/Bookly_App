import 'package:bookly_app/features/home/data/models/book_model.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<BookModel> books;

  SearchSuccess(this.books);
}

final class SearchFailure extends SearchState {
  final String errMessage;

  SearchFailure(this.errMessage);
}
