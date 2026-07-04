import 'package:bookly_app/constants.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(color: kHintTextColor),
        suffixIcon: IconButton(
          focusNode: FocusNode(skipTraversal: true),
          onPressed: () {},
          icon: Icon(Icons.search_outlined, size: 30, color: kHintTextColor),
        ),
        border: customBorder(kEnabledBorderColor),
        enabledBorder: customBorder(kEnabledBorderColor),
        focusedBorder: customBorder(kFocusedBorderColor),
        errorBorder: customBorder(kErrorBorderColor),
        focusedErrorBorder: customBorder(kErrorBorderColor),
      ),
    );
  }

  OutlineInputBorder customBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(9),
      borderSide: BorderSide(color: borderColor, width: 1.5),
    );
  }
}
