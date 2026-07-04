import 'package:bookly_app/features/home/presentation/widgets/custom_book_button.dart';
import 'package:flutter/material.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({
    super.key,
  });

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
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                backgroundColor: Colors.white,
                textColor: Colors.black, text: r'19.99$',
              ),
            ),
            Expanded(
              child: CustomBookButton(
                borderRadius: BorderRadiusGeometry.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                backgroundColor: Color(0XFFEF8363),
                textColor: Colors.white, text: 'Free Preview',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
