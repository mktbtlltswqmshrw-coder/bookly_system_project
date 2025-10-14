import 'package:bookly_system/core/theme/dark_theme.dart';
import 'package:bookly_system/core/theme/light_theme.dart';
import 'package:flutter/material.dart';

/// مدير ثيمات التطبيق
class AppTheme {
  AppTheme._();

  /// ثيم الوضع النهاري
  static ThemeData get lightTheme => getLightTheme();

  /// ثيم الوضع الليلي
  static ThemeData get darkTheme => getDarkTheme();

  /// الحصول على الثيم حسب الوضع
  static ThemeData getThemeByMode(ThemeMode mode, Brightness brightness) {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return brightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }
}

