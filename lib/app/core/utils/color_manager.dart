import 'package:flutter/material.dart';

abstract class ColorManager {
  //static const Color PRIMARY = Color(0xFF6691E7);
  static const Color PRIMARY = Color(0xFF1D55F1);
  static const Color SECONDARY = Color(0xFFFCFCFC);
  static const Color GRAY = Color(0xFFF2F4F8);
  static const Color CARD = Color(0xFF6482F1);
  static const Color FONT = Colors.black;

  /// light
  static MaterialColor get PRIMARY_MAIN =>
      MaterialColor(PRIMARY.value, _getSwatch(PRIMARY));

  static Map<int, Color> _getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    final lowDivisor = 6;

    final highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}
