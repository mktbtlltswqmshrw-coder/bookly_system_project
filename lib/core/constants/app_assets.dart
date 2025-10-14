/// مسارات الأصول (Assets) في التطبيق
class AppAssets {
  AppAssets._();

  // ========== المسارات الأساسية ==========
  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';
  static const String _illustrationsPath = 'assets/illustrations';

  // ========== الصور ==========

  /// شعار التطبيق
  static const String logo = '$_imagesPath/logo.png';
  static const String logoWhite = '$_imagesPath/logo_white.png';

  /// صورة افتراضية للمنتج
  static const String placeholderProduct = '$_imagesPath/placeholder_product.png';

  /// صورة افتراضية للمستخدم
  static const String placeholderUser = '$_imagesPath/placeholder_user.png';

  /// صورة الخلفية
  static const String backgroundLogin = '$_imagesPath/background_login.png';

  // ========== الأيقونات ==========

  /// أيقونات الفئات
  static const String iconBook = '$_iconsPath/book.svg';
  static const String iconNotebook = '$_iconsPath/notebook.svg';
  static const String iconStationery = '$_iconsPath/stationery.svg';
  static const String iconPen = '$_iconsPath/pen.svg';
  static const String iconPencil = '$_iconsPath/pencil.svg';

  /// أيقونات الإجراءات
  static const String iconEdit = '$_iconsPath/edit.svg';
  static const String iconDelete = '$_iconsPath/delete.svg';
  static const String iconAdd = '$_iconsPath/add.svg';
  static const String iconSearch = '$_iconsPath/search.svg';
  static const String iconFilter = '$_iconsPath/filter.svg';

  // ========== الرسوم التوضيحية ==========

  /// حالة فارغة
  static const String illustrationEmpty = '$_illustrationsPath/empty.svg';
  static const String illustrationNoData = '$_illustrationsPath/no_data.svg';

  /// حالة خطأ
  static const String illustrationError = '$_illustrationsPath/error.svg';
  static const String illustrationNoConnection = '$_illustrationsPath/no_connection.svg';

  /// حالة نجاح
  static const String illustrationSuccess = '$_illustrationsPath/success.svg';

  /// صفحات خاصة
  static const String illustrationUnderConstruction = '$_illustrationsPath/under_construction.svg';
  static const String illustration404 = '$_illustrationsPath/404.svg';
  static const String illustrationNoPermission = '$_illustrationsPath/no_permission.svg';

  // ========== ملاحظة ==========
  // يجب إنشاء مجلدات assets وإضافة الملفات المطلوبة
  // ثم تفعيلها في pubspec.yaml
}
