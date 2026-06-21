import 'package:bookly_app/constants.dart';
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
  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.02,
        left: size.width * 0.015,
        right: size.width * 0.015,
      ),
      child: TextFormField(
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword && obscureText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: kHintTextColor),
          prefixIcon: Icon(widget.prefixIcon, color: kHintTextColor),
          suffixIcon: (widget.isPassword)
              ? IconButton(
                  focusNode: FocusNode(skipTraversal: true),
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
          border: customBorder(kEnabledBorderColor),
          enabledBorder: customBorder(kEnabledBorderColor),
          focusedBorder: customBorder(kFocusedBorderColor),
          errorBorder: customBorder(kErrorBorderColor),
          focusedErrorBorder: customBorder(kErrorBorderColor),
        ),
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
