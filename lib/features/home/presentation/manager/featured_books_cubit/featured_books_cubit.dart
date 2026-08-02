import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/home/presentation/manager/featured_books_cubit/featured_books_state.dart';
import 'package:flutter/material.dart';


class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitial()){debugPrint("FeaturedBooksCubit created");}
  

  final HomeRepo homeRepo;

  Future<void> fetchFeaturedBooks() async {
    debugPrint("fetchFeaturedBooks called");
    emit(FeaturedBooksLoading());
    
      final result = await homeRepo.fetchFeaturedBooks();
      debugPrint(result.toString());

      result.fold(
        (failure) {
          debugPrint("FeaturedBooksCubit created");
          emit(FeaturedBooksFailure(failure.errMessage));
        },
        (books) {
          debugPrint("Books count: ${books.length}");
          emit(FeaturedBooksSuccess(books));
        },
      );

    
  }
}
