import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomRedirectText extends StatelessWidget {
  const CustomRedirectText({
    super.key,
    required this.text,
    required this.textButton,
    required this.onPressed,
  });

  final String text;
  final String textButton;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: Styles.textStyle12.copyWith(color: kHintTextColor)),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            textButton,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w700,
              color: kTextButtonColor,
            ),
          ),
        ),
      ],
    );
  }
}
