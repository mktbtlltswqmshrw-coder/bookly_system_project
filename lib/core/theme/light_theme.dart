import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

/// ثيم الوضع النهاري
ThemeData getLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // ========== نظام الألوان ==========
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryLight,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.primaryLightVariant,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.secondaryLightVariant,
      tertiary: AppColors.accentLight,
      onTertiary: Colors.white,
      error: AppColors.errorLight,
      onError: Colors.white,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.errorLight,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
      surfaceContainerHighest: AppColors.backgroundLight,
      onSurfaceVariant: AppColors.textSecondaryLight,
      outline: AppColors.borderLight,
      outlineVariant: AppColors.dividerLight,
    ),

    // ========== خلفية التطبيق ==========
    scaffoldBackgroundColor: AppColors.backgroundLight,

    // ========== App Bar ==========
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.surfaceLight,
      foregroundColor: AppColors.textPrimaryLight,
      iconTheme: IconThemeData(color: AppColors.primaryLight),
      titleTextStyle: TextStyle(color: AppColors.textPrimaryLight, fontSize: 20, fontWeight: FontWeight.bold),
      shadowColor: Colors.transparent,
    ),

    // ========== الكاردات ==========
    cardTheme: CardThemeData(
      elevation: AppDimensions.elevationLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMD)),
      color: AppColors.surfaceLight,
      surfaceTintColor: Colors.transparent,
    ),

    // ========== الأزرار ==========

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppDimensions.elevationLow,
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeightMD),
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMD)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeightMD),
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
        side: const BorderSide(color: AppColors.primaryLight, width: AppDimensions.borderMedium),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMD)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeightMD),
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMD),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Icon Button
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: AppColors.primaryLight, iconSize: AppDimensions.iconMD),
    ),

    // Floating Action Button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: AppDimensions.elevationMedium,
      backgroundColor: AppColors.primaryLight,
      foregroundColor: Colors.white,
      iconSize: AppDimensions.iconMD,
    ),

    // ========== حقول الإدخال ==========
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceLight,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMD,
        vertical: AppDimensions.paddingSM,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.borderLight, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.borderLight, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.errorLight, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        borderSide: const BorderSide(color: AppColors.errorLight, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 14),
      hintStyle: const TextStyle(color: AppColors.textDisabledLight, fontSize: 14),
      errorStyle: const TextStyle(color: AppColors.errorLight, fontSize: 12),
    ),

    // ========== Checkbox ==========
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusXS)),
    ),

    // ========== Radio ==========
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLight;
        }
        return AppColors.textSecondaryLight;
      }),
    ),

    // ========== Switch ==========
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLight;
        }
        return AppColors.textDisabledLight;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryContainer;
        }
        return AppColors.dividerLight;
      }),
    ),

    // ========== Dialog ==========
    dialogTheme: DialogThemeData(
      elevation: AppDimensions.elevationHigh,
      backgroundColor: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusLG)),
    ),

    // ========== Bottom Sheet ==========
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: AppDimensions.elevationHigh,
      backgroundColor: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusLG),
          topRight: Radius.circular(AppDimensions.radiusLG),
        ),
      ),
    ),

    // ========== Divider ==========
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerLight,
      thickness: AppDimensions.borderThin,
      space: AppDimensions.spaceMD,
    ),

    // ========== Progress Indicator ==========
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryLight,
      linearTrackColor: AppColors.primaryContainer,
      circularTrackColor: AppColors.primaryContainer,
    ),

    // ========== Chip ==========
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primaryContainer,
      selectedColor: AppColors.primaryLight,
      labelStyle: const TextStyle(color: AppColors.textPrimaryLight),
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingSM, vertical: AppDimensions.paddingXS),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSM)),
    ),

    // ========== Data Table ==========
    dataTableTheme: const DataTableThemeData(
      headingRowColor: WidgetStatePropertyAll(AppColors.primaryContainer),
      dataRowColor: WidgetStatePropertyAll(AppColors.surfaceLight),
      dividerThickness: AppDimensions.borderThin,
      headingTextStyle: TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold, fontSize: 14),
      dataTextStyle: TextStyle(color: AppColors.textPrimaryLight, fontSize: 14),
    ),

    // ========== النصوص ==========
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimaryLight),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimaryLight),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimaryLight),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimaryLight),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimaryLight),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimaryLight),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textPrimaryLight),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textPrimaryLight),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimaryLight),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimaryLight),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textPrimaryLight),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textSecondaryLight),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimaryLight),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondaryLight),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondaryLight),
    ),

    // ========== الأيقونات ==========
    iconTheme: const IconThemeData(color: AppColors.textPrimaryLight, size: AppDimensions.iconMD),
  );
}
