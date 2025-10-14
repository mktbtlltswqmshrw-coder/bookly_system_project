/// نصوص التطبيق - جميع النصوص المستخدمة في التطبيق
class AppStrings {
  AppStrings._();

  // ========== عام ==========
  static const String appName = 'نظام إدارة المكتبة';
  static const String appVersion = '1.0.0';

  static const String yes = 'نعم';
  static const String no = 'لا';
  static const String ok = 'حسناً';
  static const String cancel = 'إلغاء';
  static const String save = 'حفظ';
  static const String delete = 'حذف';
  static const String edit = 'تعديل';
  static const String add = 'إضافة';
  static const String search = 'بحث';
  static const String filter = 'تصفية';
  static const String refresh = 'تحديث';
  static const String close = 'إغلاق';
  static const String back = 'رجوع';
  static const String next = 'التالي';
  static const String previous = 'السابق';
  static const String submit = 'إرسال';
  static const String confirm = 'تأكيد';
  static const String clear = 'مسح';
  static const String select = 'اختيار';
  static const String loading = 'جاري التحميل...';
  static const String noData = 'لا توجد بيانات';
  static const String error = 'خطأ';
  static const String success = 'نجح';
  static const String warning = 'تحذير';
  static const String info = 'معلومة';

  // ========== تسجيل الدخول والحساب ==========
  static const String login = 'تسجيل الدخول';
  static const String logout = 'تسجيل الخروج';
  static const String email = 'البريد الإلكتروني';
  static const String password = 'كلمة المرور';
  static const String rememberMe = 'تذكرني';
  static const String forgotPassword = 'نسيت كلمة المرور؟';
  static const String welcomeBack = 'مرحباً بعودتك';
  static const String loginToContinue = 'سجل الدخول للمتابعة';
  static const String logoutConfirmation = 'هل تريد تسجيل الخروج؟';

  // ========== Dashboard (لوحة التحكم) ==========
  static const String dashboard = 'لوحة التحكم';
  static const String overview = 'نظرة عامة';
  static const String statistics = 'الإحصائيات';
  static const String totalProducts = 'إجمالي المنتجات';
  static const String lowStockProducts = 'منتجات منخفضة المخزون';
  static const String todaySales = 'مبيعات اليوم';
  static const String todayRevenue = 'إيرادات اليوم';
  static const String monthlyRevenue = 'إيرادات الشهر';
  static const String pendingInvoices = 'فواتير معلقة';
  static const String recentSales = 'المبيعات الأخيرة';
  static const String lowStockAlert = 'تنبيه المخزون المنخفض';
  static const String viewAll = 'عرض الكل';

  // ========== المنتجات ==========
  static const String products = 'المنتجات';
  static const String product = 'منتج';
  static const String productName = 'اسم المنتج';
  static const String productNameAr = 'الاسم بالعربي';
  static const String productDetails = 'تفاصيل المنتج';
  static const String addProduct = 'إضافة منتج';
  static const String editProduct = 'تعديل المنتج';
  static const String deleteProduct = 'حذف المنتج';
  static const String deleteProductConfirmation = 'هل أنت متأكد من حذف هذا المنتج؟';
  static const String productAdded = 'تم إضافة المنتج بنجاح';
  static const String productUpdated = 'تم تحديث المنتج بنجاح';
  static const String productDeleted = 'تم حذف المنتج بنجاح';
  static const String sku = 'كود المنتج';
  static const String barcode = 'الباركود';
  static const String unit = 'الوحدة';
  static const String costPrice = 'سعر الشراء';
  static const String sellingPrice = 'سعر البيع';
  static const String currentStock = 'المخزون الحالي';
  static const String minStockLevel = 'الحد الأدنى للمخزون';
  static const String productImage = 'صورة المنتج';
  static const String uploadImage = 'رفع صورة';
  static const String changeImage = 'تغيير الصورة';
  static const String description = 'الوصف';
  static const String active = 'نشط';
  static const String inactive = 'غير نشط';

  // ========== الفئات ==========
  static const String categories = 'الفئات';
  static const String category = 'الفئة';
  static const String categoryName = 'اسم الفئة';
  static const String categoryNameAr = 'الاسم بالعربي';
  static const String addCategory = 'إضافة فئة';
  static const String editCategory = 'تعديل الفئة';
  static const String deleteCategory = 'حذف الفئة';
  static const String deleteCategoryConfirmation = 'هل أنت متأكد من حذف هذه الفئة؟';
  static const String categoryAdded = 'تم إضافة الفئة بنجاح';
  static const String categoryUpdated = 'تم تحديث الفئة بنجاح';
  static const String categoryDeleted = 'تم حذف الفئة بنجاح';
  static const String parentCategory = 'الفئة الرئيسية';
  static const String subCategory = 'فئة فرعية';
  static const String mainCategory = 'فئة رئيسية';
  static const String icon = 'الأيقونة';
  static const String sortOrder = 'ترتيب العرض';

  // ========== الموردين ==========
  static const String suppliers = 'الموردين';
  static const String supplier = 'المورد';
  static const String supplierName = 'اسم المورد';
  static const String addSupplier = 'إضافة مورد';
  static const String editSupplier = 'تعديل المورد';
  static const String deleteSupplier = 'حذف المورد';
  static const String deleteSupplierConfirmation = 'هل أنت متأكد من حذف هذا المورد؟';
  static const String supplierAdded = 'تم إضافة المورد بنجاح';
  static const String supplierUpdated = 'تم تحديث المورد بنجاح';
  static const String supplierDeleted = 'تم حذف المورد بنجاح';
  static const String contactPerson = 'الشخص المسؤول';
  static const String phone = 'رقم الهاتف';
  static const String address = 'العنوان';
  static const String notes = 'ملاحظات';

  // ========== المخزون ==========
  static const String stock = 'المخزون';
  static const String stockMovements = 'حركة المخزون';
  static const String addStockMovement = 'إضافة حركة مخزون';
  static const String stockIn = 'وارد';
  static const String stockOut = 'صادر';
  static const String stockAdjustment = 'تعديل المخزون';
  static const String quantity = 'الكمية';
  static const String unitCost = 'سعر الوحدة';
  static const String movementType = 'نوع الحركة';
  static const String referenceType = 'نوع المرجع';
  static const String referenceNumber = 'رقم المرجع';
  static const String lowStock = 'مخزون منخفض';
  static const String outOfStock = 'نفذ من المخزون';
  static const String inStock = 'متوفر';

  // ========== الفواتير ==========
  static const String invoices = 'الفواتير';
  static const String invoice = 'الفاتورة';
  static const String invoiceNumber = 'رقم الفاتورة';
  static const String invoiceDate = 'تاريخ الفاتورة';
  static const String salesInvoice = 'فاتورة مبيعات';
  static const String purchaseInvoice = 'فاتورة مشتريات';
  static const String createSalesInvoice = 'إنشاء فاتورة مبيعات';
  static const String createPurchaseInvoice = 'إنشاء فاتورة مشتريات';
  static const String invoiceDetails = 'تفاصيل الفاتورة';
  static const String deleteInvoice = 'حذف الفاتورة';
  static const String deleteInvoiceConfirmation = 'هل أنت متأكد من حذف هذه الفاتورة؟';
  static const String invoiceCreated = 'تم إنشاء الفاتورة بنجاح';
  static const String invoiceDeleted = 'تم حذف الفاتورة بنجاح';
  static const String customerName = 'اسم العميل';
  static const String totalAmount = 'المبلغ الإجمالي';
  static const String discountAmount = 'مبلغ الخصم';
  static const String taxAmount = 'مبلغ الضريبة';
  static const String netAmount = 'المبلغ الصافي';
  static const String paymentStatus = 'حالة الدفع';
  static const String paidAmount = 'المبلغ المدفوع';
  static const String remainingAmount = 'المبلغ المتبقي';
  static const String paymentMethod = 'طريقة الدفع';
  static const String cash = 'نقدي';
  static const String creditCard = 'بطاقة ائتمان';
  static const String bankTransfer = 'تحويل بنكي';
  static const String pending = 'معلقة';
  static const String partial = 'دفع جزئي';
  static const String paid = 'مدفوعة';
  static const String addItem = 'إضافة عنصر';
  static const String items = 'العناصر';
  static const String unitPrice = 'سعر الوحدة';
  static const String discountPercentage = 'نسبة الخصم';
  static const String totalPrice = 'المبلغ الإجمالي';
  static const String printInvoice = 'طباعة الفاتورة';
  static const String addPayment = 'إضافة دفعة';
  static const String paymentDate = 'تاريخ الدفعة';
  static const String paymentAdded = 'تم إضافة الدفعة بنجاح';

  // ========== التقارير ==========
  static const String reports = 'التقارير';
  static const String salesReport = 'تقرير المبيعات';
  static const String purchasesReport = 'تقرير المشتريات';
  static const String stockReport = 'تقرير المخزون';
  static const String profitReport = 'تقرير الأرباح';
  static const String from = 'من';
  static const String to = 'إلى';
  static const String dateRange = 'الفترة الزمنية';
  static const String generateReport = 'إنشاء التقرير';
  static const String exportReport = 'تصدير التقرير';
  static const String exportToPdf = 'تصدير PDF';
  static const String exportToExcel = 'تصدير Excel';
  static const String totalSales = 'إجمالي المبيعات';
  static const String totalPurchases = 'إجمالي المشتريات';
  static const String totalProfit = 'إجمالي الأرباح';
  static const String profitMargin = 'هامش الربح';

  // ========== المستخدمين والصلاحيات ==========
  static const String users = 'المستخدمين';
  static const String user = 'المستخدم';
  static const String addUser = 'إضافة مستخدم';
  static const String editUser = 'تعديل المستخدم';
  static const String deleteUser = 'حذف المستخدم';
  static const String deleteUserConfirmation = 'هل أنت متأكد من حذف هذا المستخدم؟';
  static const String userAdded = 'تم إضافة المستخدم بنجاح';
  static const String userUpdated = 'تم تحديث المستخدم بنجاح';
  static const String userDeleted = 'تم حذف المستخدم بنجاح';
  static const String fullName = 'الاسم الكامل';
  static const String role = 'الدور';
  static const String admin = 'مدير';
  static const String employee = 'موظف';
  static const String permissions = 'الصلاحيات';
  static const String managePermissions = 'إدارة الصلاحيات';
  static const String activateUser = 'تفعيل المستخدم';
  static const String deactivateUser = 'إيقاف المستخدم';
  static const String userActivated = 'تم تفعيل المستخدم بنجاح';
  static const String userDeactivated = 'تم إيقاف المستخدم بنجاح';

  // ========== الصلاحيات التفصيلية ==========
  static const String viewProducts = 'عرض المنتجات';
  static const String addProductPermission = 'إضافة منتج';
  static const String editProductPermission = 'تعديل منتج';
  static const String deleteProductPermission = 'حذف منتج';
  static const String viewCategories = 'عرض الفئات';
  static const String manageCategories = 'إدارة الفئات';
  static const String viewInvoices = 'عرض الفواتير';
  static const String createSalesInvoicePermission = 'إنشاء فاتورة مبيعات';
  static const String createPurchaseInvoicePermission = 'إنشاء فاتورة مشتريات';
  static const String deleteInvoicePermission = 'حذف فاتورة';
  static const String viewStock = 'عرض المخزون';
  static const String adjustStock = 'تعديل المخزون';
  static const String viewReports = 'عرض التقارير';
  static const String exportReports = 'تصدير التقارير';
  static const String viewUsers = 'عرض المستخدمين';
  static const String manageUsers = 'إدارة المستخدمين';
  static const String managePermissionsText = 'إدارة الصلاحيات';
  static const String viewSuppliers = 'عرض الموردين';
  static const String manageSuppliers = 'إدارة الموردين';

  // ========== رسائل الأخطاء ==========
  static const String errorOccurred = 'حدث خطأ ما';
  static const String networkError = 'خطأ في الاتصال بالشبكة';
  static const String serverError = 'خطأ في الخادم';
  static const String authError = 'خطأ في المصادقة';
  static const String invalidCredentials = 'بيانات الدخول غير صحيحة';
  static const String fieldRequired = 'هذا الحقل مطلوب';
  static const String invalidEmail = 'البريد الإلكتروني غير صحيح';
  static const String invalidPhone = 'رقم الهاتف غير صحيح';
  static const String invalidNumber = 'الرقم غير صحيح';
  static const String invalidPrice = 'السعر غير صحيح';
  static const String invalidQuantity = 'الكمية غير صحيحة';
  static const String passwordTooShort = 'كلمة المرور قصيرة جداً';
  static const String noPermission = 'ليس لديك صلاحية لهذه العملية';
  static const String dataNotFound = 'البيانات غير موجودة';
  static const String connectionTimeout = 'انتهت مهلة الاتصال';

  // ========== رسائل النجاح ==========
  static const String operationSuccess = 'تمت العملية بنجاح';
  static const String dataSaved = 'تم حفظ البيانات بنجاح';
  static const String dataDeleted = 'تم حذف البيانات بنجاح';
  static const String dataUpdated = 'تم تحديث البيانات بنجاح';

  // ========== الإعدادات ==========
  static const String settings = 'الإعدادات';
  static const String darkMode = 'الوضع الليلي';
  static const String lightMode = 'الوضع النهاري';
  static const String language = 'اللغة';
  static const String arabic = 'العربية';
  static const String profile = 'الملف الشخصي';
  static const String changePassword = 'تغيير كلمة المرور';
  static const String about = 'حول التطبيق';

  // ========== وحدات القياس ==========
  static const String piece = 'قطعة';
  static const String box = 'كرتون';
  static const String pack = 'حزمة';
  static const String ream = 'رزمة';
  static const String dozen = 'دستة';
  static const String set = 'طقم';

  // ========== العملة ==========
  static const String currency = 'د.ع'; // دينار عراقي
  static const String iqd = 'دينار عراقي';
}
