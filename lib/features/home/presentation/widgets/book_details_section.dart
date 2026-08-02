import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/book_rating.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_cubit.dart';
import 'package:bookly_app/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:bookly_app/features/home/presentation/widgets/books_action.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.book});
  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.watch<FavoriteCubit>();
    final isFavorite = favoriteCubit.isFavorite(book.id);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.28,
          ),
          child: Stack(
            children: [
              CustomBookImage(imageUrl: book.thumbnail),

              Positioned(
                top: 6,
                right: 6,
                child: FavoriteButton(
                  width: 32,
                  height: 32,
                  size: 20,
                  isFavorite: isFavorite,
                  onPressed: () {
                    context.read<FavoriteCubit>().toggleFavorite(book);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          book.title,
          style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Text(
          book.author,
          style: Styles.textStyle18.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        BookRating(
          mainAxisAlignment: MainAxisAlignment.center,
          rating: book.ratingText,
          ratingCount: book.ratingCount,
        ),
        const SizedBox(height: 30),
        BooksAction(book: book),
      ],
    );
  }
}
