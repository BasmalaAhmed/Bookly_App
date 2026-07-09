import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_state.dart';


class SimilarBooksCubit extends Cubit<SimilarBooksState> {
  SimilarBooksCubit(this.homeRepo) : super(SimilarBooksInitial());

  final HomeRepo homeRepo;

  Future<void> fetchSimilarBooks({required String category}) async {
    emit(SimilarBooksLoading());
    
      final booksResult = await homeRepo.fetchSimilarBooks(category: category);

      booksResult.fold(
        (failure) {
          emit(SimilarBooksFailure(failure.errMessage));
        },
        (books) {
          emit(SimilarBooksSuccess(books));
        },
      );

    
  }
}
