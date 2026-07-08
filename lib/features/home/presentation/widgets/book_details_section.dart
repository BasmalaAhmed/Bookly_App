import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/book_rating.dart';
import 'package:bookly_app/features/home/presentation/widgets/books_action.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.28),
          child: const CustomBookImage(imageUrl: 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSz2I0c_d8ZodmvN-m0Fosa9jj8v_m9uLpsvbtbvIOtY_6mxxItuwoTRETucn8oDHlyUJtH5WovlxzVfm6U9uZr7851WYlAuBcxn58bdc0Z&usqp=CAc',),
        ),
        const SizedBox(height: 32),
        Text(
          'The Jungle Book',
          style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: 0.7,
          child: Text(
            'Rudyard Kipling',
            style: Styles.textStyle18.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 6),
        const BookRating(mainAxisAlignment: MainAxisAlignment.center),
        const SizedBox(height: 30),
        const BooksAction(),
      ],
    );
  }
}
