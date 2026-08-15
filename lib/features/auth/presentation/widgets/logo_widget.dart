import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/assets.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isDark ? Colors.white : kButtonColor,
        BlendMode.srcIn,
      ),
      child: Image.asset(AssetsData.logo, scale: scale),
    );
  }
}
