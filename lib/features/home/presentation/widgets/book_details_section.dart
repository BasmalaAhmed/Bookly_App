import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/book_rating.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:bookly_app/features/home/presentation/widgets/books_action.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.book});
  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.28),
          child: CustomBookImage(imageUrl: book.thumbnail,),
        ),
        const SizedBox(height: 32),
        Text(
          book.title,
          style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: 0.7,
          child: Text(
            book.author,
            style: Styles.textStyle18.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 6),
        BookRating(mainAxisAlignment: MainAxisAlignment.center, rating: book.ratingText, ratingCount: book.ratingCount,),
        const SizedBox(height: 30),
        BooksAction(book: book,),
      ],
    );
  }
}
