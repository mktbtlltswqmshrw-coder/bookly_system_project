import 'package:intl/intl.dart';

/// مجموعة من formatters لتنسيق البيانات
class Formatters {
  Formatters._();

  // ========== تنسيق العملة ==========

  /// تنسيق العملة العراقية (دينار)
  static String formatCurrency(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'ar_IQ',
      symbol: 'د.ع',
      decimalDigits: 0, // الدينار العراقي لا يستخدم الكسور عادة
    );
    return formatter.format(amount);
  }

  /// تنسيق العملة بدون رمز
  static String formatCurrencyWithoutSymbol(num amount) {
    final formatter = NumberFormat.currency(locale: 'ar_IQ', symbol: '', decimalDigits: 0);
    return formatter.format(amount).trim();
  }

  /// تنسيق العملة بكسور عشرية
  static String formatCurrencyWithDecimals(num amount, {int decimals = 2}) {
    final formatter = NumberFormat.currency(locale: 'ar_IQ', symbol: 'د.ع', decimalDigits: decimals);
    return formatter.format(amount);
  }

  // ========== تنسيق الأرقام ==========

  /// تنسيق رقم مع فواصل الآلاف
  static String formatNumber(num number) {
    final formatter = NumberFormat.decimalPattern('ar_IQ');
    return formatter.format(number);
  }

  /// تنسيق رقم مع كسور عشرية محددة
  static String formatNumberWithDecimals(num number, {int decimals = 2}) {
    return number.toStringAsFixed(decimals);
  }

  /// تنسيق النسبة المئوية
  static String formatPercentage(num percentage, {bool includeSymbol = true}) {
    final formatted = percentage.toStringAsFixed(1);
    return includeSymbol ? '$formatted%' : formatted;
  }

  // ========== تنسيق التاريخ والوقت ==========

  /// تنسيق التاريخ (يوم/شهر/سنة)
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy', 'ar').format(date);
  }

  /// تنسيق التاريخ مع اسم الشهر
  static String formatDateWithMonthName(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'ar').format(date);
  }

  /// تنسيق الوقت (ساعة:دقيقة)
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm', 'ar').format(time);
  }

  /// تنسيق التاريخ والوقت
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm', 'ar').format(dateTime);
  }

  /// تنسيق التاريخ النسبي (منذ ساعة، منذ يوم، الخ)
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return 'منذ $weeks أسبوع';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return 'منذ $months شهر';
    } else {
      final years = (difference.inDays / 365).floor();
      return 'منذ $years سنة';
    }
  }

  /// تنسيق اسم الشهر
  static String formatMonthName(int month) {
    final months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return months[month - 1];
  }

  /// تنسيق اسم اليوم
  static String formatDayName(int day) {
    final days = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
    return days[day - 1];
  }

  // ========== تنسيق رقم الهاتف ==========

  /// تنسيق رقم الهاتف العراقي
  static String formatIraqiPhone(String phone) {
    // إزالة المسافات والشرطات
    final cleaned = phone.replaceAll(RegExp(r'[\s-]'), '');

    // تنسيق: 07XX-XXX-XXXX
    if (cleaned.length == 11 && cleaned.startsWith('07')) {
      return '${cleaned.substring(0, 4)}-${cleaned.substring(4, 7)}-${cleaned.substring(7)}';
    }

    return phone; // إرجاع الرقم كما هو إذا لم يكن بالتنسيق الصحيح
  }

  // ========== تنسيق حجم الملف ==========

  /// تنسيق حجم الملف (بايت، كيلوبايت، ميجابايت)
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes بايت';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} كيلوبايت';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} ميجابايت';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} جيجابايت';
    }
  }

  // ========== تنسيق حالة الفاتورة ==========

  /// تنسيق حالة الدفع
  static String formatPaymentStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'معلقة';
      case 'partial':
        return 'دفع جزئي';
      case 'paid':
        return 'مدفوعة';
      default:
        return status;
    }
  }

  /// تنسيق نوع الفاتورة
  static String formatInvoiceType(String type) {
    switch (type.toLowerCase()) {
      case 'sales':
        return 'فاتورة مبيعات';
      case 'purchase':
        return 'فاتورة مشتريات';
      default:
        return type;
    }
  }

  /// تنسيق نوع حركة المخزون
  static String formatMovementType(String type) {
    switch (type.toLowerCase()) {
      case 'in':
        return 'وارد';
      case 'out':
        return 'صادر';
      case 'adjustment':
        return 'تعديل';
      default:
        return type;
    }
  }

  // ========== تنسيق النص ==========

  /// اختصار النص مع إضافة نقاط
  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}$suffix';
  }

  /// تحويل الحرف الأول لكبير
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// تحويل أول حرف من كل كلمة لكبير
  static String capitalizeWords(String text) {
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }
}
