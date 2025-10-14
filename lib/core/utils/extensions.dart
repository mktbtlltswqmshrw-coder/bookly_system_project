import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

// ========== String Extensions ==========

extension StringExtensions on String {
  /// التحقق من أن النص فارغ أو null
  bool get isNullOrEmpty => trim().isEmpty;

  /// التحقق من أن النص ليس فارغاً أو null
  bool get isNotNullOrEmpty => trim().isNotEmpty;

  /// تحويل أول حرف لكبير
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// إزالة الأحرف الخاصة
  String get removeSpecialCharacters {
    return replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  /// التحقق من أن النص يحتوي على أرقام فقط
  bool get isNumeric {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  /// التحقق من أن النص بريد إلكتروني
  bool get isEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
  }

  /// تحويل النص إلى رقم صحيح
  int? get toIntOrNull {
    return int.tryParse(this);
  }

  /// تحويل النص إلى رقم عشري
  double? get toDoubleOrNull {
    return double.tryParse(this);
  }
}

// ========== DateTime Extensions ==========

extension DateTimeExtensions on DateTime {
  /// التحقق من أن التاريخ اليوم
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// التحقق من أن التاريخ بالأمس
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  /// التحقق من أن التاريخ في المستقبل
  bool get isFuture {
    return isAfter(DateTime.now());
  }

  /// التحقق من أن التاريخ في الماضي
  bool get isPast {
    return isBefore(DateTime.now());
  }

  /// الحصول على بداية اليوم
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// الحصول على نهاية اليوم
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59);
  }

  /// الحصول على بداية الشهر
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  /// الحصول على نهاية الشهر
  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0, 23, 59, 59);
  }

  /// إضافة أيام
  DateTime addDays(int days) {
    return add(Duration(days: days));
  }

  /// طرح أيام
  DateTime subtractDays(int days) {
    return subtract(Duration(days: days));
  }
}

// ========== BuildContext Extensions ==========

extension BuildContextExtensions on BuildContext {
  /// الحصول على Theme
  ThemeData get theme => Theme.of(this);

  /// الحصول على TextTheme
  TextTheme get textTheme => theme.textTheme;

  /// الحصول على ColorScheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// الحصول على MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// الحصول على حجم الشاشة
  Size get screenSize => mediaQuery.size;

  /// الحصول على عرض الشاشة
  double get screenWidth => screenSize.width;

  /// الحصول على ارتفاع الشاشة
  double get screenHeight => screenSize.height;

  /// التحقق من أن الشاشة صغيرة (موبايل)
  bool get isMobile => screenWidth < 600;

  /// التحقق من أن الشاشة متوسطة (تابلت)
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;

  /// التحقق من أن الشاشة كبيرة (ديسكتوب)
  bool get isDesktop => screenWidth >= 1200;

  /// الحصول على اتجاه الشاشة
  Orientation get orientation => mediaQuery.orientation;

  /// التحقق من أن الاتجاه portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// التحقق من أن الاتجاه landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// إغلاق الكيبورد
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// الانتقال إلى صفحة جديدة
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// الانتقال إلى صفحة جديدة مع استبدال الحالية
  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.of(this).pushReplacement<T, void>(MaterialPageRoute(builder: (_) => page));
  }

  /// العودة للصفحة السابقة
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// إظهار SnackBar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: isError ? colorScheme.error : colorScheme.primary),
    );
  }
}

// ========== List Extensions ==========

extension ListExtensions<T> on List<T> {
  /// التحقق من أن القائمة فارغة أو null
  bool get isNullOrEmpty => isEmpty;

  /// التحقق من أن القائمة ليست فارغة أو null
  bool get isNotNullOrEmpty => isNotEmpty;

  /// الحصول على العنصر الأول أو null
  T? get firstOrNull => isEmpty ? null : first;

  /// الحصول على العنصر الأخير أو null
  T? get lastOrNull => isEmpty ? null : last;
}

// ========== Dartz Either Extensions ==========

extension EitherExtensions<L, R> on Either<L, R> {
  /// الحصول على القيمة اليمنى (Right)
  R getRight() => (this as Right<L, R>).value;

  /// الحصول على القيمة اليسرى (Left)
  L getLeft() => (this as Left<L, R>).value;

  /// التحقق من أن القيمة Right
  bool get isRight => this is Right<L, R>;

  /// التحقق من أن القيمة Left
  bool get isLeft => this is Left<L, R>;

  /// تحويل إلى Widget حسب الحالة
  Widget when({required Widget Function(L failure) failure, required Widget Function(R data) success}) {
    return fold((l) => failure(l), (r) => success(r));
  }

  /// ربط عمليات متسلسلة يمكن أن تفشل
  Either<L, T> flatMap<T>(Either<L, T> Function(R r) f) {
    return fold((l) => Left(l), (r) => f(r));
  }

  /// تطبيق دالة على القيمة اليمنى
  Either<L, T> mapRight<T>(T Function(R r) f) {
    return fold((l) => Left(l), (r) => Right(f(r)));
  }

  /// تطبيق دالة على القيمة اليسرى
  Either<T, R> mapLeft<T>(T Function(L l) f) {
    return fold((l) => Left(f(l)), (r) => Right(r));
  }
}

// ========== Num Extensions ==========

extension NumExtensions on num {
  /// التحقق من أن الرقم موجب
  bool get isPositive => this > 0;

  /// التحقق من أن الرقم سالب
  bool get isNegative => this < 0;

  /// التحقق من أن الرقم صفر
  bool get isZero => this == 0;

  /// الحصول على القيمة المطلقة
  num get absoluteValue => abs();
}

// ========== Color Extensions ==========

extension ColorExtensions on Color {
  /// التحقق من أن اللون فاتح
  bool get isLight => computeLuminance() > 0.5;

  /// التحقق من أن اللون داكن
  bool get isDark => computeLuminance() <= 0.5;

  /// الحصول على لون نصي مناسب (أبيض أو أسود)
  Color get textColor => isLight ? Colors.black : Colors.white;
}
