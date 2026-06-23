import 'package:bookly_app/constants.dart';
import 'package:flutter/material.dart';

class CustomRedirectText extends StatelessWidget {
  const CustomRedirectText({
    super.key,
    required this.text,
    required this.textButton, required this.onPressed,
  });

  final String text;
  final String textButton;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: TextStyle(color: kHintTextColor , fontSize: 12)),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
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
