

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kovaii_fine_coat/theme/palettes.dart';
import 'package:kovaii_fine_coat/theme/text_style.dart';

final AppTextStyle _textStyle = AppTextStyle.instance;

ThemeData lightMode = ThemeData(
  fontFamily: GoogleFonts.roboto().fontFamily,
  appBarTheme: AppBarTheme(backgroundColor: Palettes.transparentColor),
  splashColor: Palettes.transparentColor,
  hoverColor: Palettes.whiteColor,
  highlightColor: Palettes.whiteColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Palettes.whiteColor,
  primaryColor: Palettes.primaryColor,
  colorScheme: ColorScheme.light(
    primaryFixed: Palettes.greyTextColor,
    inversePrimary: Palettes.disableColor,
    primary: Palettes.primaryColor,
    secondary: Palettes.secondaryColor,
    tertiary: Palettes.textColor,
    outline: Palettes.greyFieldColor,
    primaryContainer: Palettes.actionColor,
    secondaryContainer: Palettes.whiteColor,
    tertiaryContainer: Palettes.buttonGreyColor,
    surfaceDim: Palettes.table2Color,
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    displayLarge: _textStyle.displayLarge,
    displayMedium: _textStyle.displayMedium,
    displaySmall: _textStyle.displaySmall,
    headlineLarge: _textStyle.headlineLarge,
    headlineMedium: _textStyle.headlineMedium,
    headlineSmall: _textStyle.headlineSmall,
    titleLarge: _textStyle.titleLarge,
    titleMedium: _textStyle.titleMedium,
    titleSmall: _textStyle.titleSmall,
    labelLarge: _textStyle.labelLarge,
    labelMedium: _textStyle.labelMedium,
    labelSmall: _textStyle.labelSmall,
    bodyLarge: _textStyle.bodyLarge,

    bodySmall: _textStyle.bodySmall,
  ),
  // inputDecorationTheme:
  inputDecorationTheme: InputDecorationTheme(
    hoverColor: Palettes.whiteColor,
    filled: true,
    fillColor: Palettes.whiteColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    hintStyle: _textStyle.titleSmall.copyWith(
      color: Palettes.greyTextColor,
      fontWeight: FontWeight.w400,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),

      borderSide: BorderSide(color: Palettes.buttonGreyColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide.none,
    ),
  ),
);

ThemeData darkMode = ThemeData(
  fontFamily: GoogleFonts.roboto().fontFamily,
  appBarTheme: AppBarTheme(backgroundColor: Palettes.transparentColor),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Palettes.darkBgColor,
  primaryColor: Palettes.primaryColor,
  colorScheme: ColorScheme.dark(
    primary: Palettes.primaryColor,
    surface: Palettes.darkBgColor,
    secondary: Palettes.darkMenuColor,
    tertiary: Palettes.secondaryColor,
    outline: Palettes.outlineDark,
    primaryContainer: Palettes.darkTileColor,
    secondaryContainer: Palettes.darkMenuColor,
    tertiaryContainer: Palettes.buttonGreyColor,
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    displayLarge: _textStyle.displayLarge.copyWith(
      color: Palettes.secondaryColor,
    ),
    displayMedium: _textStyle.displayMedium.copyWith(
      color: Palettes.secondaryColor,
    ),
    displaySmall: _textStyle.displaySmall.copyWith(
      color: Palettes.secondaryColor,
    ),
    headlineLarge: _textStyle.headlineLarge.copyWith(
      color: Palettes.secondaryColor,
    ),
    headlineMedium: _textStyle.headlineMedium.copyWith(
      color: Palettes.secondaryColor,
    ),
    headlineSmall: _textStyle.headlineSmall.copyWith(
      color: Palettes.secondaryColor,
    ),
    titleLarge: _textStyle.titleLarge.copyWith(color: Palettes.secondaryColor),
    titleSmall: _textStyle.titleSmall.copyWith(color: Palettes.secondaryColor),
    titleMedium: _textStyle.titleMedium.copyWith(
      color: Palettes.secondaryColor,
    ),
    labelLarge: _textStyle.labelLarge.copyWith(
      color: Palettes.whiteLabelTextColor,
    ),
    labelMedium: _textStyle.labelMedium.copyWith(
      color: Palettes.whiteLabelTextColor,
    ),
    labelSmall: _textStyle.labelSmall.copyWith(
      color: Palettes.whiteLabelTextColor,
    ),
    bodyLarge: _textStyle.bodyLarge.copyWith(color: Palettes.whiteTextColor),

    bodySmall: _textStyle.bodySmall.copyWith(color: Palettes.whiteTextColor),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    isDense: true,
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Palettes.redColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Palettes.primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Palettes.redColor, width: 2),
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
  ),
);
