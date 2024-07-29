import 'package:flutter/material.dart';
import '/core/theme/app_color.dart';

const kGlobalBorderRadiusInternal = Radius.circular(8.0);
const kGlobalBorderRadiusExternal = Radius.circular(16.0);

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
