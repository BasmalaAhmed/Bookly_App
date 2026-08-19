import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  Color? color,
  FaIcon icon = const FaIcon(FontAwesomeIcons.envelopeCircleCheck, size: 42),
  bool showCancel = false,
  String cancelTitle = 'Cancel',
  bool isDelete = false,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final buttonColor = color ?? colorScheme.secondary;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 50),
        backgroundColor: colorScheme.outlineVariant.withValues(alpha: 0.6),
        child: LiquidGlassLayer(
          child: LiquidGlass(
            shape: LiquidRoundedRectangle(borderRadius: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(radius: 36, backgroundColor: isDelete ? colorScheme.onError : colorScheme.primary ,child: icon),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: Styles.textStyle20.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    style: Styles.textStyle14.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  if (showCancel)
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              
                              child: Text(
                                cancelTitle,
                                style: Styles.textStyle16.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              onPressed();
                            },
                            color: buttonColor,
                            child: Text(
                              buttonTitle,
                              style: Styles.textStyle16.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    CustomButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        onPressed();
                      },
                      color: buttonColor,
                      child: Text(
                        buttonTitle,
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
