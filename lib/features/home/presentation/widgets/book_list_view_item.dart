import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/book_rating.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:bookly_app/features/home/presentation/widgets/newest_books_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookListViewItem extends StatelessWidget {
  const BookListViewItem({super.key, required this.bookModel,});
  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).push(AppRouter.kBookDetailsView , extra: bookModel);
      },
      child: SizedBox(
        height: 140,
        child: Row(
          children: [
            NewestBooksImage(imageUrl: bookModel.thumbnail),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle20.copyWith(
                      fontFamily: kGTSectraFine,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(bookModel.author, style: Styles.textStyle14),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(bookModel.priceText, style: Styles.textStyle20.copyWith(
                        fontWeight: FontWeight.bold,
                      ),),
                      Spacer(),
                      BookRating(rating: bookModel.ratingText, ratingCount: bookModel.ratingCount,),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
