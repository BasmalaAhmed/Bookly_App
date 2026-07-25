import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String buttonTitle,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 218),
        child: Dialog(
          backgroundColor: kBackgroundColor.withValues(alpha: 0.6),
          child: LiquidGlassLayer(
            child: LiquidGlass(
              shape: LiquidRoundedRectangle(borderRadius: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 26,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: kButtonColor.withValues(alpha: .15),
                      child: Icon(
                        Icons.mark_email_read_rounded,
                        color: kButtonColor,
                        size: 38,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: Styles.textStyle18,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      message,
                      style: Styles.textStyle14.copyWith(height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),
                    CustomButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        onPressed();
                      },
                      child: Text(buttonTitle, style: Styles.textStyle16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
