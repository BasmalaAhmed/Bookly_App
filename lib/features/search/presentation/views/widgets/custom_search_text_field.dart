import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      style: Styles.textStyle16,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: Styles.textStyle16.copyWith(color: kHintTextColor),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search_outlined,
            size: 30,
            color: kHintTextColor,
          ),
        ),
        border: _customBorder(kEnabledBorderColor),
        enabledBorder: _customBorder(kEnabledBorderColor),
        focusedBorder: _customBorder(kFocusedBorderColor),
        errorBorder: _customBorder(kErrorBorderColor),
        focusedErrorBorder: _customBorder(kErrorBorderColor),
      ),
    );
  }

  static OutlineInputBorder _customBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: borderColor, width: 1.5),
    );
  }
}
