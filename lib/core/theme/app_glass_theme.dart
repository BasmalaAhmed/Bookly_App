import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

abstract class AppGlassTheme {
  static const darkSettings = LiquidGlassSettings(
    thickness: 14,
    blur: 6,
    glassColor: Color(0X14FFFFFF),
    lightIntensity: 1.0,
    ambientStrength: 0.15,
    refractiveIndex: 1.25,
    saturation: 1.3,
  );

  static const lightSettings = LiquidGlassSettings(
    thickness: 12,
    blur: 7,
    glassColor: Color(0X66FFFFFF),
    lightIntensity: 0.85,
    ambientStrength: 0.2,
    refractiveIndex: 1.25,
    saturation: 1.15,
  );

  static LiquidGlassSettings settings(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSettings
        : lightSettings;
  }
}
