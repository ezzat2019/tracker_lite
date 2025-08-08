import 'package:flutter/material.dart';

import 'color_manager.dart';

abstract class ThemeManager {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "SF",
    appBarTheme: AppBarTheme(backgroundColor: ColorManager.SECONDARY),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorManager.PRIMARY,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.PRIMARY),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.PRIMARY),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: ColorManager.FONT),
      bodyMedium: TextStyle(color: ColorManager.FONT),
      bodySmall: TextStyle(color: ColorManager.FONT),
      headlineLarge: TextStyle(color: ColorManager.FONT),
      headlineMedium: TextStyle(color: ColorManager.FONT),
      headlineSmall: TextStyle(color: ColorManager.FONT),
      titleLarge: TextStyle(color: ColorManager.FONT),
      titleMedium: TextStyle(color: ColorManager.FONT),
      titleSmall: TextStyle(color: ColorManager.FONT),
    ),
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: ColorManager.PRIMARY_MAIN)
            .copyWith(surface: ColorManager.SECONDARY),
  );
}
