import 'package:bookly_app/core/utils/functions/launch_url.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_book_button.dart';
import 'package:flutter/material.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomBookButton(
                onPressed: (){
                  laucnhCustomUrl(context, book.buyLink);
                },
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                backgroundColor: Colors.white,
                textColor: Colors.black,
                text: book.priceText,
              ),
            ),
            Expanded(
              child: CustomBookButton(
                onPressed: () {
                  laucnhCustomUrl(context, book.previewLink);
                },
                borderRadius: BorderRadiusGeometry.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                backgroundColor: Color(0XFFEF8363),
                textColor: Colors.white,
                text: getText(book),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String getText(BookModel book) {
    if (book.previewLink == null){
      return 'Not Available';
    }
    else{
      return 'Preview';
    }
  }
}
