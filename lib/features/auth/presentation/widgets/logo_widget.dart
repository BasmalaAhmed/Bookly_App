import 'package:bookly_app/core/utils/assets.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isDark ? colorScheme.onSurface : colorScheme.secondary,
        BlendMode.srcIn,
      ),
      child: Image.asset(AssetsData.logo, scale: scale),
    );
  }
}
