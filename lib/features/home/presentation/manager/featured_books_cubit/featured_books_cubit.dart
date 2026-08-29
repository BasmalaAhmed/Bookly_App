import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/home/presentation/manager/featured_books_cubit/featured_books_state.dart';
import 'package:flutter/material.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitial()) {
    debugPrint("FeaturedBooksCubit created");
  }

  final HomeRepo homeRepo;

  Future<void> fetchFeaturedBooks() async {
    if (isClosed) return;
    emit(FeaturedBooksLoading());

    final result = await homeRepo.fetchFeaturedBooks();
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(FeaturedBooksFailure(failure.errMessage));
      },
      (books) {
        emit(FeaturedBooksSuccess(books));
      },
    );
  }
}
