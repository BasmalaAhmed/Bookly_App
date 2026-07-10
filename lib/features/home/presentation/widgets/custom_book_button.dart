import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomBookButton extends StatelessWidget {
  const CustomBookButton({
    super.key,
    required this.borderRadius,
    required this.backgroundColor,
    required this.textColor,
    required this.text, this.onPressed,
  });

  final BorderRadiusGeometry borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
