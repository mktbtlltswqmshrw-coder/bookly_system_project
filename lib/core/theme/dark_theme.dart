import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

/// ثيم الوضع الليلي
ThemeData getDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // ========== نظام الألوان ==========
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      onPrimary: Colors.black,
      primaryContainer: AppColors.primaryContainerDark,
      onPrimaryContainer: AppColors.primaryDarkVariant,
      secondary: AppColors.secondaryDark,
      onSecondary: Colors.black,
      secondaryContainer: AppColors.secondaryContainerDark,
      onSecondaryContainer: AppColors.secondaryDarkVariant,
      tertiary: AppColors.accentDark,
      onTertiary: Colors.black,
      error: AppColors.errorDark,
      onError: Colors.black,
      errorContainer: AppColors.errorContainerDark,
      onErrorContainer: AppColors.errorDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      surfaceContainerHighest: AppColors.backgroundDark,
      onSurfaceVariant: AppColors.textSecondaryDark,
      outline: AppColors.borderDark,
      outlineVariant: AppColors.dividerDark,
    ),

    // ========== خلفية التطبيق ==========
    scaffoldBackgroundColor: AppColors.backgroundDark,

    // ========== App Bar ==========
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.textPrimaryDark,
      iconTheme: IconThemeData(color: AppColors.primaryDark),
      titleTextStyle: TextStyle(color: AppColors.textPrimaryDark, fontSize: 20, fontWeight: FontWeight.bold),
      shadowColor: Colors.transparent,
    ),

    // ========== الكاردات ==========
    cardTheme: CardThemeData(
      elevation: AppDimensions.elevationLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMD)),
      color: AppColors.surfaceDark,
      surfaceTintColor: Colors.transparent,
    ),

    // ========== الأزرار ==========

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppDimensions.elevationLow,
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.backgroundDark,
        minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeightMD),
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMD)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeightMD),
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
        side: const BorderSide(color: AppColors.primaryDark, width: AppDimensions.borderMedium),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMD)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeightMD),
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMD),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Icon Button
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: AppColors.primaryDark, iconSize: AppDimensions.iconMD),
    ),

    // Floating Action Button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: AppDimensions.elevationMedium,
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.backgroundDark,
      iconSize: AppDimensions.iconMD,
    ),

    // ========== حقول الإدخال ==========
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceVariantDark,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMD,
        vertical: AppDimensions.paddingSM,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.errorDark),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.errorDark, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 14),
      hintStyle: const TextStyle(color: AppColors.textDisabledDark, fontSize: 14),
      errorStyle: const TextStyle(color: AppColors.errorDark, fontSize: 12),
    ),

    // ========== Checkbox ==========
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryDark;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.backgroundDark),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusXS)),
    ),

    // ========== Radio ==========
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryDark;
        }
        return AppColors.textSecondaryDark;
      }),
    ),

    // ========== Switch ==========
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryDark;
        }
        return AppColors.textDisabledDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryContainerDark;
        }
        return AppColors.dividerDark;
      }),
    ),

    // ========== Dialog ==========
    dialogTheme: DialogThemeData(
      elevation: AppDimensions.elevationHigh,
      backgroundColor: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusLG)),
    ),

    // ========== Bottom Sheet ==========
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: AppDimensions.elevationHigh,
      backgroundColor: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusLG),
          topRight: Radius.circular(AppDimensions.radiusLG),
        ),
      ),
    ),

    // ========== Divider ==========
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerDark,
      thickness: AppDimensions.borderThin,
      space: AppDimensions.spaceMD,
    ),

    // ========== Progress Indicator ==========
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryDark,
      linearTrackColor: AppColors.primaryContainerDark,
      circularTrackColor: AppColors.primaryContainerDark,
    ),

    // ========== Chip ==========
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primaryContainerDark,
      selectedColor: AppColors.primaryDark,
      labelStyle: const TextStyle(color: AppColors.textPrimaryDark),
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingSM, vertical: AppDimensions.paddingXS),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSM)),
    ),

    // ========== Data Table ==========
    dataTableTheme: const DataTableThemeData(
      headingRowColor: WidgetStatePropertyAll(AppColors.primaryContainerDark),
      dataRowColor: WidgetStatePropertyAll(AppColors.surfaceDark),
      dividerThickness: AppDimensions.borderThin,
      headingTextStyle: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 14),
      dataTextStyle: TextStyle(color: AppColors.textPrimaryDark, fontSize: 14),
    ),

    // ========== النصوص ==========
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimaryDark),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimaryDark),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimaryDark),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimaryDark),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textPrimaryDark),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textSecondaryDark),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondaryDark),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondaryDark),
    ),

    // ========== الأيقونات ==========
    iconTheme: const IconThemeData(color: AppColors.textPrimaryDark, size: AppDimensions.iconMD),
  );
}
