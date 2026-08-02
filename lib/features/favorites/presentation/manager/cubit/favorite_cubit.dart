import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_state.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteRepo) : super(FavoriteInitial());

  final FavoriteRepo favoriteRepo;
  final Set<String> _favoriteIds = {};

  Future<void> fetchFavoriteBooks() async {
    emit(FavoriteLoading());

    final result = await favoriteRepo.fetchFavorites();

    result.fold(
  (failure) {
    _favoriteIds.clear();
    emit(FavoriteFailure(failure.errMessage));
  },
  (books) {
    _favoriteIds
      ..clear()
      ..addAll(books.map((book) => book.id));

    emit(FavoriteSuccess(books));
  },
);
  }

  Future<void> addFavorite(BookModel book) async {
    final result = await favoriteRepo.addFavorite(book);

    result.fold(
      (failure) {
        emit(FavoriteFailure(failure.errMessage));
      },
      (_) => fetchFavoriteBooks()
    );
  }

  Future<void> removeFavorite(String id) async {
    final result = await favoriteRepo.removeFavorite(id);

    result.fold(
      (failure) {
        emit(FavoriteFailure(failure.errMessage));
      },
      (_) => fetchFavoriteBooks()
    );
  }

  bool isFavorite(String id) {
    return _favoriteIds.contains(id);
  }

  Future<void> toggleFavorite(BookModel book) async {
    if(isFavorite(book.id)){
      await removeFavorite(book.id);
    } else {
      await addFavorite(book);
    }
  }
}
