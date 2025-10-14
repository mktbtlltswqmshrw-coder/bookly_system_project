import 'package:equatable/equatable.dart';

/// كيان المستخدم - Domain Entity
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final UserRole role;
  final List<String> permissions;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    required this.role,
    required this.permissions,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  /// هل المستخدم Admin؟
  bool get isAdmin => role == UserRole.admin;

  /// هل المستخدم موظف؟
  bool get isEmployee => role == UserRole.employee;

  /// هل المستخدم لديه صلاحية معينة؟
  bool hasPermission(String permission) {
    if (isAdmin) return true; // Admin لديه كل الصلاحيات
    return permissions.contains(permission);
  }

  @override
  List<Object?> get props => [id, email, fullName, phone, role, permissions, isActive, createdAt, updatedAt];
}

/// أدوار المستخدمين
enum UserRole {
  admin('admin', 'مدير'),
  employee('employee', 'موظف');

  final String value;
  final String nameAr;

  const UserRole(this.value, this.nameAr);

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere((role) => role.value == value, orElse: () => UserRole.employee);
  }
}

/// الصلاحيات المتاحة في النظام
class AppPermissions {
  AppPermissions._();

  // Products
  static const String viewProducts = 'view_products';
  static const String addProduct = 'add_product';
  static const String editProduct = 'edit_product';
  static const String deleteProduct = 'delete_product';

  // Categories
  static const String viewCategories = 'view_categories';
  static const String manageCategories = 'manage_categories';

  // Invoices
  static const String viewInvoices = 'view_invoices';
  static const String createSalesInvoice = 'create_sales_invoice';
  static const String createPurchaseInvoice = 'create_purchase_invoice';
  static const String deleteInvoice = 'delete_invoice';

  // Stock
  static const String viewStock = 'view_stock';
  static const String adjustStock = 'adjust_stock';

  // Reports
  static const String viewReports = 'view_reports';
  static const String exportReports = 'export_reports';

  // Users
  static const String viewUsers = 'view_users';
  static const String manageUsers = 'manage_users';
  static const String managePermissions = 'manage_permissions';

  // Suppliers
  static const String viewSuppliers = 'view_suppliers';
  static const String manageSuppliers = 'manage_suppliers';

  /// جميع الصلاحيات
  static const List<String> all = [
    viewProducts,
    addProduct,
    editProduct,
    deleteProduct,
    viewCategories,
    manageCategories,
    viewInvoices,
    createSalesInvoice,
    createPurchaseInvoice,
    deleteInvoice,
    viewStock,
    adjustStock,
    viewReports,
    exportReports,
    viewUsers,
    manageUsers,
    managePermissions,
    viewSuppliers,
    manageSuppliers,
  ];
}
