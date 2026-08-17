import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookRating extends StatelessWidget {
  const BookRating({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.rating,
    required this.ratingCount,
  });
  final MainAxisAlignment mainAxisAlignment;
  final String rating;
  final int ratingCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        const FaIcon(FontAwesomeIcons.solidStar, color: Color(0xFFE6C63F), size: 14),
        const SizedBox(width: 3),
        Text(rating, style: Styles.textStyle16),
        const SizedBox(width: 4),
        Text('($ratingCount)', style: Styles.textStyle14.copyWith(color: Color(0xFF707070))),
      ],
    );
  }
}
