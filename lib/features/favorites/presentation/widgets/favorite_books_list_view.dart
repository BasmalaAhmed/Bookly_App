import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/custom_error_widget.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_cubit.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_state.dart';
import 'package:bookly_app/features/favorites/presentation/widgets/animated_favorite_book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavoriteBooksListView extends StatefulWidget {
  const FavoriteBooksListView({super.key});

  @override
  State<FavoriteBooksListView> createState() => _FavoriteBooksListViewState();
}

class _FavoriteBooksListViewState extends State<FavoriteBooksListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteSuccess) {
          final books = state.books;
          if (books.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.heartCrack,
                    color: Colors.grey,
                    size: 90,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No favorite books yet\nTap the ♥ icon on any book to add it here.',
                    style: Styles.textStyle16,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: AnimatedFavoriteBookItem(
                  key: ValueKey(books[index].id),
                  book: books[index],
                ),
              );
            }, childCount: books.length),
          );
        } else if (state is FavoriteFailure) {
          return SliverFillRemaining(
            child: CustomErrorMessage(errMessage: state.errMessage),
          );
        } else {
          return const SliverFillRemaining(
            child: Center(child: LoadingIndicator()),
          );
        }
      },
    );
  }
}
