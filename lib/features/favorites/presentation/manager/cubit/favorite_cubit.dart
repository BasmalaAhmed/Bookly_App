import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_state.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteRepo) : super(FavoriteInitial());

  final FavoriteRepo favoriteRepo;

  Future<void> fetchFavoriteBooks() async {
    emit(FavoriteLoading());

    final result = await favoriteRepo.fetchFavorites();

    result.fold(
      (failure) => emit(FavoriteFailure(failure.errMessage)),
      (books) => emit(FavoriteSuccess(books))
      
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

  Future<bool> isFavorite(String id) async {
    final result = await favoriteRepo.isFavorite(id);
    return result.fold((_) => false, (isFavorite) => isFavorite);
  }
}
