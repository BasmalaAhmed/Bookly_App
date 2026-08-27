import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_state.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:bookly_app/features/notifications/data/models/notification_model.dart';
import 'package:bookly_app/features/notifications/data/models/notification_type.dart';
import 'package:bookly_app/features/notifications/data/repos/notification_repo.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteRepo, this.notificationRepo)
    : super(FavoriteInitial());

  final FavoriteRepo favoriteRepo;
  final NotificationRepo notificationRepo;
  final Set<String> _favoriteIds = {};
  final Set<String> _togglingIds = {};

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
      (_) {
        if (state is! FavoriteSuccess) return;
        final currentBooks = List<BookModel>.from(
          (state as FavoriteSuccess).books,
        );

        currentBooks.removeWhere((b) => b.id == book.id);

        currentBooks.add(book);

        _favoriteIds.add(book.id);

        emit(FavoriteSuccess(currentBooks));

        _notifyFavoriteAdded(book);
      },
    );
  }

  Future<void> removeFavorite(String id) async {
    final result = await favoriteRepo.removeFavorite(id);

    result.fold(
      (failure) {
        emit(FavoriteFailure(failure.errMessage));
      },
      (_) {
        if (state is! FavoriteSuccess) return;
        final currentBooks = List<BookModel>.from(
          (state as FavoriteSuccess).books,
        );

        currentBooks.removeWhere((b) => b.id == id);

        _favoriteIds.remove(id);

        emit(FavoriteSuccess(currentBooks));
      },
    );
  }

  bool isFavorite(String id) {
    return _favoriteIds.contains(id);
  }

  Future<void> toggleFavorite(BookModel book) async {
    if (_togglingIds.contains(book.id)) return;

    _togglingIds.add(book.id);

    try {
      if (isFavorite(book.id)) {
        await removeFavorite(book.id);
      } else {
        await addFavorite(book);
      }
    } finally {
      _togglingIds.remove(book.id);
    }
  }

  Future<void> _notifyFavoriteAdded(BookModel book) async {
    try {
      await notificationRepo.createNotification(
        NotificationModel(
          id: '',
          title: 'Added to favorites',
          message: '"${book.title}" was added to your favorites.',
          createdAt: DateTime.now(),
          isRead: false,
          type: NotificationType.favorite,
          bookId: book.id,
        ),
      );
    } catch (e) {
      print('Failed to create favorite notification : $e');
    }
  }
}
