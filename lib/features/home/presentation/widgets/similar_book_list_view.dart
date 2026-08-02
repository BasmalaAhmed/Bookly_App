import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/widgets/custom_error_widget.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_cubit.dart';
import 'package:bookly_app/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_state.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SimilarBookListView extends StatelessWidget {
  const SimilarBookListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
      builder: (context, state) {
        if (state is SimilarBooksSuccess) {
          final favoriteCubit = context.watch<FavoriteCubit>();
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.2,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                final isFavorite = favoriteCubit.isFavorite(
                  book.id,
                );
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      context.push(
                        AppRouter.kBookDetailsView,
                        extra: book,
                      );
                    },
                    child: Stack(
                      children: [
                        CustomBookImage(imageUrl: book.thumbnail),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: FavoriteButton(
                            width: 26,
                            height: 26,
                            size: 14,
                            isFavorite: isFavorite,
                            onPressed: () {
                              context.read<FavoriteCubit>().toggleFavorite(book);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is SimilarBooksFailure) {
          return Center(
            child: CustomErrorMessage(errMessage: state.errMessage),
          );
        } else {
          return const Center(child: LoadingIndicator());
        }
      },
    );
  }
}
