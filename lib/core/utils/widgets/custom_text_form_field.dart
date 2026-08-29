import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.validator,
  });

  final String hintText;
  final FaIconData prefixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;
  late final FocusNode _suffixFocusNode;
  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
    _suffixFocusNode = FocusNode(skipTraversal: true);
  }

  @override
  void dispose() {
    _suffixFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: widget.controller,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && obscureText,
      style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Styles.textStyle16.copyWith(color: colorScheme.onSurfaceVariant),
        prefixIcon: FaIcon(widget.prefixIcon, color: colorScheme.onSurface),
        suffixIcon: widget.isPassword
            ? IconButton(
              focusNode: _suffixFocusNode,
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: FaIcon(
                  (obscureText)
                      ? FontAwesomeIcons.eyeSlash
                      : FontAwesomeIcons.eye,
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            : null,
        border: _buildBorder(colorScheme.outline),
        enabledBorder: _buildBorder(colorScheme.outline),
        focusedBorder: _buildBorder(colorScheme.primary),
        errorBorder: _buildBorder(colorScheme.error),
        focusedErrorBorder: _buildBorder(colorScheme.error),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: borderColor, width: 1.5),
    );
  }
}
