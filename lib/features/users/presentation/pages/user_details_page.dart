import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/utils/formatters.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/presentation/widgets/user_role_badge_widget.dart';
import 'package:flutter/material.dart';

/// صفحة تفاصيل المستخدم
class UserDetailsPage extends StatelessWidget {
  final UserEntity user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المستخدم'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit
            },
            tooltip: AppStrings.edit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          children: [
            // معلومات المستخدم
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLG),
                child: Column(
                  children: [
                    // الصورة الشخصية
                    CircleAvatar(
                      radius: AppDimensions.imageAvatarLG,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: AppDimensions.iconXL,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceMD),

                    // الاسم
                    Text(
                      user.fullName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.spaceSM),

                    // البريد
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondaryLight),
                    ),
                    const SizedBox(height: AppDimensions.spaceMD),

                    // الدور والحالة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UserRoleBadgeWidget(role: user.role),
                        const SizedBox(width: AppDimensions.spaceMD),
                        Chip(
                          label: Text(user.isActive ? AppStrings.active : AppStrings.inactive),
                          backgroundColor: user.isActive
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.errorLight.withOpacity(0.1),
                          side: BorderSide(color: user.isActive ? AppColors.success : AppColors.errorLight),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spaceMD),

            // تفاصيل إضافية
            _DetailCard(
              title: 'معلومات الاتصال',
              children: [
                if (user.phone != null)
                  _DetailItem(
                    icon: Icons.phone,
                    label: AppStrings.phone,
                    value: Formatters.formatIraqiPhone(user.phone!),
                  ),
                _DetailItem(icon: Icons.email, label: AppStrings.email, value: user.email),
              ],
            ),

            const SizedBox(height: AppDimensions.spaceMD),

            // التواريخ
            _DetailCard(
              title: 'التواريخ',
              children: [
                _DetailItem(
                  icon: Icons.calendar_today,
                  label: 'تاريخ الإنشاء',
                  value: Formatters.formatDateTime(user.createdAt),
                ),
                _DetailItem(icon: Icons.update, label: 'آخر تحديث', value: Formatters.formatDateTime(user.updatedAt)),
              ],
            ),

            // الصلاحيات (للموظفين فقط)
            if (user.role == UserRole.employee) ...[
              const SizedBox(height: AppDimensions.spaceMD),
              _DetailCard(
                title: AppStrings.permissions,
                children: [
                  if (user.permissions.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingMD),
                      child: Text(
                        'لا توجد صلاحيات',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondaryLight),
                      ),
                    )
                  else
                    Wrap(
                      spacing: AppDimensions.spaceSM,
                      runSpacing: AppDimensions.spaceSM,
                      children: user.permissions.map((permission) {
                        return Chip(
                          label: Text(_getPermissionName(permission)),
                          avatar: const Icon(Icons.check, size: AppDimensions.iconSM),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getPermissionName(String permission) {
    final permissionNames = {
      AppPermissions.viewProducts: AppStrings.viewProducts,
      AppPermissions.addProduct: AppStrings.addProductPermission,
      AppPermissions.editProduct: AppStrings.editProductPermission,
      AppPermissions.deleteProduct: AppStrings.deleteProductPermission,
      AppPermissions.viewCategories: AppStrings.viewCategories,
      AppPermissions.manageCategories: AppStrings.manageCategories,
      AppPermissions.viewInvoices: AppStrings.viewInvoices,
      AppPermissions.createSalesInvoice: AppStrings.createSalesInvoicePermission,
      AppPermissions.createPurchaseInvoice: AppStrings.createPurchaseInvoicePermission,
      AppPermissions.deleteInvoice: AppStrings.deleteInvoicePermission,
      AppPermissions.viewStock: AppStrings.viewStock,
      AppPermissions.adjustStock: AppStrings.adjustStock,
      AppPermissions.viewReports: AppStrings.viewReports,
      AppPermissions.exportReports: AppStrings.exportReports,
      AppPermissions.viewUsers: AppStrings.viewUsers,
      AppPermissions.manageUsers: AppStrings.manageUsers,
      AppPermissions.managePermissions: AppStrings.managePermissionsText,
      AppPermissions.viewSuppliers: AppStrings.viewSuppliers,
      AppPermissions.manageSuppliers: AppStrings.manageSuppliers,
    };

    return permissionNames[permission] ?? permission;
  }
}

/// كارد التفاصيل
class _DetailCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _DetailCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: AppDimensions.spaceMD),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// عنصر التفاصيل
class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingSM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: AppDimensions.iconMD, color: AppColors.textSecondaryLight),
          const SizedBox(width: AppDimensions.spaceMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryLight),
                ),
                const SizedBox(height: AppDimensions.spaceXS),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
