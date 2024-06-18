import 'package:flutter/material.dart';
import '/core/theme/app_color.dart';

const kGlobalShapeBorder = Radius.circular(16.0);
const kGlobalBorderRadius = Radius.circular(32.0);

class AppTheme {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primaryColor,
    fontFamily: "Metrolopis",
    fontFamilyFallback: const [],
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColor.primaryColor,
    ),
  );
}
