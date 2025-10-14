import 'package:flutter/material.dart';

/// ألوان التطبيق - نظام ألوان متكامل للمود الليلي والنهاري
class AppColors {
  AppColors._();

  // ========== الألوان الرئيسية - الوضع النهاري ==========
  // نظام ألوان بني/جوزي مع أبيض وأسود

  /// اللون الأساسي - بني جوزي داكن
  static const Color primaryLight = Color(0xFF6D4C41); // Brown 700
  static const Color primaryLightVariant = Color(0xFF5D4037); // Brown 800
  static const Color primaryContainer = Color(0xFFD7CCC8); // Brown 100

  /// اللون الثانوي - بني فاتح
  static const Color secondaryLight = Color(0xFF8D6E63); // Brown 400
  static const Color secondaryLightVariant = Color(0xFFA1887F); // Brown 300
  static const Color secondaryContainer = Color(0xFFEFEBE9); // Brown 50

  /// اللون التحفيزي - بني محمص
  static const Color accentLight = Color(0xFF795548); // Brown 500
  static const Color accentLightVariant = Color(0xFF6D4C41);

  /// خلفية التطبيق
  static const Color backgroundLight = Color(0xFF121212); // أسود داكن مريح للعين
  static const Color surfaceLight = Color(0xFF1E1E1E); // رمادي داكن جداً

  /// لون الخطأ
  static const Color errorLight = Color(0xFFD32F2F);
  static const Color errorContainer = Color(0xFFFFCDD2);

  // ========== الألوان الرئيسية - الوضع الليلي ==========

  /// اللون الأساسي - بني فاتح للداكن
  static const Color primaryDark = Color(0xFFBCAAA4); // Brown 200
  static const Color primaryDarkVariant = Color(0xFFA1887F); // Brown 300
  static const Color primaryContainerDark = Color(0xFF4E342E); // Brown 900

  /// اللون الثانوي - بني محايد
  static const Color secondaryDark = Color(0xFFD7CCC8); // Brown 100
  static const Color secondaryDarkVariant = Color(0xFFEFEBE9); // Brown 50
  static const Color secondaryContainerDark = Color(0xFF5D4037); // Brown 800

  /// اللون التحفيزي
  static const Color accentDark = Color(0xFFBCAAA4);
  static const Color accentDarkVariant = Color(0xFFD7CCC8);

  /// خلفية التطبيق
  static const Color backgroundDark = Color(0xFF121212); // أسود داكن
  static const Color surfaceDark = Color(0xFF1E1E1E); // رمادي داكن جداً
  static const Color surfaceVariantDark = Color(0xFF2C2C2C);

  /// لون الخطأ
  static const Color errorDark = Color(0xFFCF6679);
  static const Color errorContainerDark = Color(0xFF93000A);

  // ========== ألوان النص ==========

  /// نص رئيسي - الوضع النهاري
  static const Color textPrimaryLight = Color(0xFF212121); // أسود
  static const Color textSecondaryLight = Color(0xFF757575); // رمادي
  static const Color textDisabledLight = Color(0xFFBDBDBD);

  /// نص رئيسي - الوضع الليلي
  static const Color textPrimaryDark = Color(0xFFFFFFFF); // أبيض
  static const Color textSecondaryDark = Color(0xFFB0B0B0); // رمادي فاتح
  static const Color textDisabledDark = Color(0xFF616161);

  // ========== ألوان وظيفية ==========

  /// نجاح
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  /// تحذير
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  /// معلومات
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);

  /// حالة المخزون
  static const Color stockLow = Color(0xFFEF4444);
  static const Color stockMedium = Color(0xFFF59E0B);
  static const Color stockHigh = Color(0xFF10B981);

  // ========== ألوان الحدود والفواصل ==========

  static const Color dividerLight = Color(0xFFE5E7EB);
  static const Color dividerDark = Color(0xFF374151);

  static const Color borderLight = Color(0xFFD1D5DB);
  static const Color borderDark = Color(0xFF4B5563);

  // ========== ألوان خاصة بالفواتير ==========

  /// فاتورة مبيعات
  static const Color salesInvoice = Color(0xFF10B981);

  /// فاتورة شراء
  static const Color purchaseInvoice = Color(0xFF3B82F6);

  /// معلقة
  static const Color pendingStatus = Color(0xFFF59E0B);

  /// مدفوعة جزئياً
  static const Color partialStatus = Color(0xFFFBBF24);

  /// مدفوعة بالكامل
  static const Color paidStatus = Color(0xFF10B981);

  // ========== تدرجات لونية (Gradients) ==========

  /// تدرج رئيسي للكاردات والعناصر المميزة
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4A5FE8), Color(0xFF7B68EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// تدرج ثانوي
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF7B68EE), Color(0xFF9F8EFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// تدرج للخلفيات
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFF8F9FC), Color(0xFFEEF2FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ========== الظلال ==========

  /// ظل خفيف جداً (للكاردات)
  static List<BoxShadow> lightShadow = [
    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2)),
  ];

  /// ظل متوسط (للعناصر المرفوعة)
  static List<BoxShadow> mediumShadow = [
    BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4)),
  ];

  /// ظل قوي (للـ Modals و Dialogs)
  static List<BoxShadow> strongShadow = [
    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 8)),
  ];
}
