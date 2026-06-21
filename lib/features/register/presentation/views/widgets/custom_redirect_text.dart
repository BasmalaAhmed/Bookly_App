import 'package:bookly_app/constants.dart';
import 'package:flutter/material.dart';

class CustomRedirectText extends StatelessWidget {
  const CustomRedirectText({
    super.key,
    required this.text,
    required this.textButton,
  });

  final String text;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: TextStyle(color: kHintTextColor , fontSize: 12)),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: kTextButtonColor,
          ),
          child: Text(textButton, style: TextStyle(fontWeight: FontWeight.w700,
              fontSize: 14,
            ),),
        ),
      ],
    );
  }
}
