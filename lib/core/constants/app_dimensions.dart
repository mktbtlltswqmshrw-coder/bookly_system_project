/// أبعاد ومقاسات التطبيق - نظام موحد للمسافات والأحجام
class AppDimensions {
  AppDimensions._();

  // ========== المسافات (Spacing) ==========

  /// مسافة صغيرة جداً
  static const double spaceXXS = 2.0;

  /// مسافة صغيرة
  static const double spaceXS = 4.0;

  /// مسافة صغيرة متوسطة
  static const double spaceSM = 8.0;

  /// مسافة متوسطة
  static const double spaceMD = 16.0;

  /// مسافة كبيرة
  static const double spaceLG = 24.0;

  /// مسافة كبيرة جداً
  static const double spaceXL = 32.0;

  /// مسافة كبيرة جداً جداً
  static const double spaceXXL = 48.0;

  // ========== الحواف (Padding) ==========

  /// حواف صغيرة
  static const double paddingXS = 4.0;

  /// حواف صغيرة متوسطة
  static const double paddingSM = 8.0;

  /// حواف متوسطة
  static const double paddingMD = 16.0;

  /// حواف كبيرة
  static const double paddingLG = 24.0;

  /// حواف كبيرة جداً
  static const double paddingXL = 32.0;

  // ========== نصف القطر (Border Radius) ==========

  /// نصف قطر صغير
  static const double radiusXS = 4.0;

  /// نصف قطر صغير متوسط
  static const double radiusSM = 8.0;

  /// نصف قطر متوسط
  static const double radiusMD = 12.0;

  /// نصف قطر كبير
  static const double radiusLG = 16.0;

  /// نصف قطر كبير جداً
  static const double radiusXL = 24.0;

  /// نصف قطر دائري كامل
  static const double radiusFull = 999.0;

  // ========== سماكة الحدود (Border Width) ==========

  /// حد رفيع
  static const double borderThin = 1.0;

  /// حد متوسط
  static const double borderMedium = 2.0;

  /// حد سميك
  static const double borderThick = 3.0;

  // ========== أحجام الأيقونات (Icon Sizes) ==========

  /// أيقونة صغيرة جداً
  static const double iconXS = 12.0;

  /// أيقونة صغيرة
  static const double iconSM = 16.0;

  /// أيقونة متوسطة
  static const double iconMD = 24.0;

  /// أيقونة كبيرة
  static const double iconLG = 32.0;

  /// أيقونة كبيرة جداً
  static const double iconXL = 48.0;

  /// أيقونة ضخمة
  static const double iconXXL = 64.0;

  // ========== أحجام الصور (Image Sizes) ==========

  /// صورة صغيرة (Avatar)
  static const double imageAvatarSM = 32.0;
  static const double imageAvatarMD = 48.0;
  static const double imageAvatarLG = 64.0;

  /// صورة منتج
  static const double imageProductThumbnail = 80.0;
  static const double imageProductCard = 120.0;
  static const double imageProductDetail = 300.0;

  /// صورة خلفية
  static const double imageBackgroundHeight = 200.0;

  // ========== أحجام الأزرار (Button Sizes) ==========

  /// ارتفاع الزر
  static const double buttonHeightSM = 36.0;
  static const double buttonHeightMD = 48.0;
  static const double buttonHeightLG = 56.0;

  /// عرض الزر
  static const double buttonMinWidth = 88.0;

  /// زر أيقونة
  static const double buttonIconSize = 48.0;

  // ========== أحجام حقول الإدخال (Input Field Sizes) ==========

  /// ارتفاع حقل الإدخال
  static const double inputHeightSM = 40.0;
  static const double inputHeightMD = 48.0;
  static const double inputHeightLG = 56.0;

  // ========== أحجام الكاردات (Card Sizes) ==========

  /// ارتفاع الكارد
  static const double cardHeightSM = 80.0;
  static const double cardHeightMD = 120.0;
  static const double cardHeightLG = 200.0;

  /// عرض الكارد (Grid)
  static const double cardWidthSM = 150.0;
  static const double cardWidthMD = 200.0;
  static const double cardWidthLG = 300.0;

  // ========== أبعاد خاصة بالتطبيق ==========

  /// عرض Navigation Rail
  static const double navRailWidth = 72.0;
  static const double navRailExpandedWidth = 256.0;

  /// ارتفاع App Bar
  static const double appBarHeight = 56.0;

  /// ارتفاع Bottom Navigation Bar
  static const double bottomNavHeight = 56.0;

  /// عرض Drawer
  static const double drawerWidth = 280.0;

  /// عرض Dialog
  static const double dialogWidthSM = 300.0;
  static const double dialogWidthMD = 400.0;
  static const double dialogWidthLG = 600.0;

  /// عرض Bottom Sheet
  static const double bottomSheetMaxHeight = 0.9; // نسبة من ارتفاع الشاشة

  // ========== أبعاد Data Table ==========

  /// ارتفاع صف الجدول
  static const double tableRowHeight = 56.0;
  static const double tableHeaderHeight = 64.0;

  /// عرض الأعمدة
  static const double tableColumnWidthSM = 80.0;
  static const double tableColumnWidthMD = 120.0;
  static const double tableColumnWidthLG = 200.0;

  // ========== أبعاد المحتوى ==========

  /// عرض المحتوى الأقصى (للشاشات الكبيرة)
  static const double maxContentWidth = 1200.0;

  /// عرض النموذج الأقصى
  static const double maxFormWidth = 600.0;

  /// ارتفاع Shimmer Loading
  static const double shimmerHeight = 20.0;

  // ========== الارتفاع (Elevation) ==========

  /// بدون ارتفاع
  static const double elevationNone = 0.0;

  /// ارتفاع منخفض
  static const double elevationLow = 2.0;

  /// ارتفاع متوسط
  static const double elevationMedium = 4.0;

  /// ارتفاع عالي
  static const double elevationHigh = 8.0;

  /// ارتفاع عالي جداً
  static const double elevationXHigh = 16.0;

  // ========== أبعاد خاصة بالفواتير ==========

  /// عرض عنصر المنتج في الفاتورة
  static const double invoiceItemHeight = 72.0;

  /// عرض ملخص الفاتورة
  static const double invoiceSummaryWidth = 300.0;

  // ========== أبعاد Charts ==========

  /// ارتفاع الرسم البياني
  static const double chartHeightSM = 150.0;
  static const double chartHeightMD = 250.0;
  static const double chartHeightLG = 350.0;

  // ========== المدة الزمنية للرسوم المتحركة (Animation Duration) ==========

  /// مدة قصيرة
  static const Duration animationDurationShort = Duration(milliseconds: 150);

  /// مدة متوسطة
  static const Duration animationDurationMedium = Duration(milliseconds: 300);

  /// مدة طويلة
  static const Duration animationDurationLong = Duration(milliseconds: 500);
}
