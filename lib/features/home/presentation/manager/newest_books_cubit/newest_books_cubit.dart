import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/home/presentation/manager/newest_books_cubit/newest_books_state.dart';


class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.homeRepo) : super(NewestBooksInitial());

  final HomeRepo homeRepo;

  Future<void> fetchNewestBooks() async {
    emit(NewestBooksLoading());
    
      final booksResult = await homeRepo.fetchNewestBooks();

      booksResult.fold(
        (failure) {
          emit(NewestBooksFailure(failure.errMessage));
        },
        (books) {
          emit(NewestBooksSuccess(books));
        },
      );

    
  }
}
