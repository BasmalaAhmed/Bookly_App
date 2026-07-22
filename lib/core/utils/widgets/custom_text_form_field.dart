import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

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
  final IconData prefixIcon;
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
      style: Styles.textStyle16,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Styles.textStyle16.copyWith(color: kHintTextColor),
        prefixIcon: Icon(widget.prefixIcon, color: kHintTextColor),
        suffixIcon: widget.isPassword
            ? IconButton(
              focusNode: _suffixFocusNode,
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  (obscureText)
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: kHintTextColor,
                ),
              )
            : null,
        border: _buildBorder(kEnabledBorderColor),
        enabledBorder: _buildBorder(kEnabledBorderColor),
        focusedBorder: _buildBorder(kFocusedBorderColor),
        errorBorder: _buildBorder(kErrorBorderColor),
        focusedErrorBorder: _buildBorder(kErrorBorderColor),
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
