import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      controller: controller,
      onSubmitted: (_) {
        FocusScope.of(context).unfocus();
        onSearch();
      },
      style: Styles.textStyle16,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: Styles.textStyle16.copyWith(color: colorScheme.onSurfaceVariant),
        suffixIcon: IconButton(
          onPressed: onSearch,
          icon: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            size: 24,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        border: _customBorder(colorScheme.outline),
        enabledBorder: _customBorder(colorScheme.outline),
        focusedBorder: _customBorder(colorScheme.primary),
        errorBorder: _customBorder(colorScheme.error),
        focusedErrorBorder: _customBorder(colorScheme.error),
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
