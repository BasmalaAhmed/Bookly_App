import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BookRating extends StatelessWidget {
  const BookRating({super.key, this.mainAxisAlignment = MainAxisAlignment.start});
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(Icons.star_rate_rounded, color: kRatingStar, size: 22,),
        SizedBox(
                  width: 3,
                ),
        Text('4.8', style: Styles.textStyle16,),
        SizedBox(
                  width: 4,
                ),
        Opacity(
          opacity: 0.5,
          child: Text('(2456)', style: Styles.textStyle14),
        ),
      ],
    );
  }
}