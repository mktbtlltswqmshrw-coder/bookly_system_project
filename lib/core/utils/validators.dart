/// مجموعة من validators للتحقق من صحة البيانات
class Validators {
  Validators._();

  /// التحقق من أن الحقل غير فارغ
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'هذا الحقل'} مطلوب';
    }
    return null;
  }

  /// التحقق من البريد الإلكتروني
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }

  /// التحقق من رقم الهاتف العراقي
  static String? iraqiPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }

    // إزالة المسافات والشرطات
    final cleanValue = value.replaceAll(RegExp(r'[\s-]'), '');

    // التحقق من رقم هاتف عراقي
    // يبدأ بـ 07 ويتبعه 9 أرقام
    final phoneRegex = RegExp(r'^07\d{9}$');

    if (!phoneRegex.hasMatch(cleanValue)) {
      return 'رقم الهاتف غير صحيح (يجب أن يبدأ بـ 07 ويحتوي على 11 رقم)';
    }
    return null;
  }

  /// التحقق من كلمة المرور
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < minLength) {
      return 'كلمة المرور يجب أن تحتوي على $minLength أحرف على الأقل';
    }
    return null;
  }

  /// التحقق من تطابق كلمة المرور
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }

    if (value != password) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  /// التحقق من رقم
  static String? number(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'الرقم'} مطلوب';
    }

    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'الرقم'} غير صحيح';
    }
    return null;
  }

  /// التحقق من رقم صحيح
  static String? integer(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'الرقم'} مطلوب';
    }

    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'الرقم'} يجب أن يكون عدد صحيح';
    }
    return null;
  }

  /// التحقق من السعر
  static String? price(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'السعر'} مطلوب';
    }

    final price = double.tryParse(value);
    if (price == null) {
      return '${fieldName ?? 'السعر'} غير صحيح';
    }

    if (price < 0) {
      return '${fieldName ?? 'السعر'} يجب أن يكون أكبر من أو يساوي صفر';
    }
    return null;
  }

  /// التحقق من الكمية
  static String? quantity(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'الكمية'} مطلوبة';
    }

    final quantity = int.tryParse(value);
    if (quantity == null) {
      return '${fieldName ?? 'الكمية'} غير صحيحة';
    }

    if (quantity <= 0) {
      return '${fieldName ?? 'الكمية'} يجب أن تكون أكبر من صفر';
    }
    return null;
  }

  /// التحقق من الحد الأدنى للطول
  static String? minLength(String? value, int min, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'هذا الحقل'} مطلوب';
    }

    if (value.length < min) {
      return '${fieldName ?? 'هذا الحقل'} يجب أن يحتوي على $min أحرف على الأقل';
    }
    return null;
  }

  /// التحقق من الحد الأقصى للطول
  static String? maxLength(String? value, int max, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null; // اختياري
    }

    if (value.length > max) {
      return '${fieldName ?? 'هذا الحقل'} يجب ألا يتجاوز $max حرف';
    }
    return null;
  }

  /// التحقق من النطاق الرقمي
  static String? range(
    String? value,
    double min,
    double max, [
    String? fieldName,
  ]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'الرقم'} مطلوب';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return '${fieldName ?? 'الرقم'} غير صحيح';
    }

    if (number < min || number > max) {
      return '${fieldName ?? 'الرقم'} يجب أن يكون بين $min و $max';
    }
    return null;
  }

  /// التحقق من كود المنتج (SKU)
  static String? sku(String? value) {
    if (value == null || value.isEmpty) {
      return null; // اختياري
    }

    // يسمح بالأحرف والأرقام والشرطات
    final skuRegex = RegExp(r'^[a-zA-Z0-9-]+$');
    if (!skuRegex.hasMatch(value)) {
      return 'كود المنتج يجب أن يحتوي على أحرف وأرقام وشرطات فقط';
    }
    return null;
  }

  /// التحقق من الباركود
  static String? barcode(String? value) {
    if (value == null || value.isEmpty) {
      return null; // اختياري
    }

    // يسمح بالأرقام فقط
    final barcodeRegex = RegExp(r'^\d+$');
    if (!barcodeRegex.hasMatch(value)) {
      return 'الباركود يجب أن يحتوي على أرقام فقط';
    }
    return null;
  }

  /// التحقق من النسبة المئوية
  static String? percentage(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null; // اختياري
    }

    final percentage = double.tryParse(value);
    if (percentage == null) {
      return '${fieldName ?? 'النسبة'} غير صحيحة';
    }

    if (percentage < 0 || percentage > 100) {
      return '${fieldName ?? 'النسبة'} يجب أن تكون بين 0 و 100';
    }
    return null;
  }

  /// دمج عدة validators
  static String? combine(
    List<String? Function(String?)> validators,
    String? value,
  ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
