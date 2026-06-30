import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BookRating extends StatelessWidget {
  const BookRating({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Icon(Icons.star_rate_rounded, color: kRatingStar,),
        SizedBox(
                  width: size.width * 0.006,
                ),
        Text('4.8', style: Styles.textStyle16,),
        SizedBox(
                  width: size.width * 0.012,
                ),
        Text('(2456)', style: Styles.textStyle14.copyWith(
          color: kRatingCount,
        ),),
      ],
    );
  }
}