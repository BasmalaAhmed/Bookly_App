import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/home/presentation/manager/featured_books_cubit/featured_books_state.dart';


class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitial());

  final HomeRepo homeRepo;

  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedBooksLoading());
    
      final booksResult = await homeRepo.fetchFeaturedBooks();

      booksResult.fold(
        (failure) {
          emit(FeaturedBooksFailure(failure.errMessage));
        },
        (books) {
          emit(FeaturedBooksSuccess(books));
        },
      );

    
  }
}
