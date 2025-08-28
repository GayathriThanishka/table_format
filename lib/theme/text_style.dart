


import 'package:flutter/material.dart';
import 'package:kovaii_fine_coat/theme/palettes.dart';

class AppTextStyle {
  static AppTextStyle instance = AppTextStyle();

  TextStyle displayLarge = TextStyle(
    color: Palettes.textColor,
    fontSize: 57,
    fontWeight: FontWeight.bold,
  );
  TextStyle displayMedium = TextStyle(
    color: Palettes.textColor,
    fontSize: 45,
    fontWeight: FontWeight.bold,
  );
  TextStyle displaySmall = TextStyle(
    color: Palettes.textColor,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );
  TextStyle headlineLarge = TextStyle(
    color: Palettes.textColor,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  TextStyle headlineMedium = TextStyle(
    color: Palettes.textColor,
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );
  TextStyle headlineSmall = TextStyle(
    color: Palettes.textColor,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  TextStyle titleLarge = TextStyle(
    fontWeight: FontWeight.bold,
    color: Palettes.textColor,
    fontSize: 22,
  );
  TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w500,
    color: Palettes.textColor,
    fontSize: 18,
  );
  TextStyle titleSmall = TextStyle(color: Palettes.textColor, fontSize: 14);
  TextStyle labelLarge = TextStyle(color: Palettes.greyTextColor, fontSize: 14);
  TextStyle labelMedium = TextStyle(
    color: Palettes.greyTextColor,
    fontSize: 12,
  );
  TextStyle labelSmall = TextStyle(color: Palettes.greyTextColor, fontSize: 11);
  TextStyle bodyLarge = TextStyle(color: Palettes.textColor, fontSize: 16);
  
  TextStyle bodySmall = TextStyle(color: Palettes.textColor, fontSize: 12);
}
