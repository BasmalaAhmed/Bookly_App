import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomBookButton extends StatelessWidget {
  const CustomBookButton({
    super.key,
    required this.borderRadius,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
  });

  final BorderRadiusGeometry borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      child: Text(
        text,
        style: Styles.textStyle16.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
