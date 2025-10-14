import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

/// Widget لاختيار صلاحيات المستخدم
class PermissionsSelectorWidget extends StatefulWidget {
  final List<String> selectedPermissions;
  final void Function(List<String>) onPermissionsChanged;

  const PermissionsSelectorWidget({super.key, required this.selectedPermissions, required this.onPermissionsChanged});

  @override
  State<PermissionsSelectorWidget> createState() => _PermissionsSelectorWidgetState();
}

class _PermissionsSelectorWidgetState extends State<PermissionsSelectorWidget> {
  late List<String> _selectedPermissions;

  @override
  void initState() {
    super.initState();
    _selectedPermissions = List.from(widget.selectedPermissions);
  }

  void _togglePermission(String permission) {
    setState(() {
      if (_selectedPermissions.contains(permission)) {
        _selectedPermissions.remove(permission);
      } else {
        _selectedPermissions.add(permission);
      }
      widget.onPermissionsChanged(_selectedPermissions);
    });
  }

  void _selectAll() {
    setState(() {
      _selectedPermissions = List.from(AppPermissions.all);
      widget.onPermissionsChanged(_selectedPermissions);
    });
  }

  void _clearAll() {
    setState(() {
      _selectedPermissions.clear();
      widget.onPermissionsChanged(_selectedPermissions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان والأزرار
            Row(
              children: [
                Text(
                  AppStrings.permissions,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _selectAll,
                  icon: const Icon(Icons.done_all, size: AppDimensions.iconSM),
                  label: const Text('تحديد الكل'),
                ),
                TextButton.icon(
                  onPressed: _clearAll,
                  icon: const Icon(Icons.clear_all, size: AppDimensions.iconSM),
                  label: const Text('إلغاء الكل'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.errorLight),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: AppDimensions.spaceMD),

            // المنتجات
            _buildPermissionSection(
              context,
              title: AppStrings.products,
              icon: Icons.inventory,
              permissions: [
                (AppPermissions.viewProducts, AppStrings.viewProducts),
                (AppPermissions.addProduct, AppStrings.addProductPermission),
                (AppPermissions.editProduct, AppStrings.editProductPermission),
                (AppPermissions.deleteProduct, AppStrings.deleteProductPermission),
              ],
            ),

            // الفئات
            _buildPermissionSection(
              context,
              title: AppStrings.categories,
              icon: Icons.category,
              permissions: [
                (AppPermissions.viewCategories, AppStrings.viewCategories),
                (AppPermissions.manageCategories, AppStrings.manageCategories),
              ],
            ),

            // الفواتير
            _buildPermissionSection(
              context,
              title: AppStrings.invoices,
              icon: Icons.receipt_long,
              permissions: [
                (AppPermissions.viewInvoices, AppStrings.viewInvoices),
                (AppPermissions.createSalesInvoice, AppStrings.createSalesInvoicePermission),
                (AppPermissions.createPurchaseInvoice, AppStrings.createPurchaseInvoicePermission),
                (AppPermissions.deleteInvoice, AppStrings.deleteInvoicePermission),
              ],
            ),

            // المخزون
            _buildPermissionSection(
              context,
              title: AppStrings.stock,
              icon: Icons.warehouse,
              permissions: [
                (AppPermissions.viewStock, AppStrings.viewStock),
                (AppPermissions.adjustStock, AppStrings.adjustStock),
              ],
            ),

            // التقارير
            _buildPermissionSection(
              context,
              title: AppStrings.reports,
              icon: Icons.bar_chart,
              permissions: [
                (AppPermissions.viewReports, AppStrings.viewReports),
                (AppPermissions.exportReports, AppStrings.exportReports),
              ],
            ),

            // المستخدمين
            _buildPermissionSection(
              context,
              title: AppStrings.users,
              icon: Icons.people,
              permissions: [
                (AppPermissions.viewUsers, AppStrings.viewUsers),
                (AppPermissions.manageUsers, AppStrings.manageUsers),
                (AppPermissions.managePermissions, AppStrings.managePermissionsText),
              ],
            ),

            // الموردين
            _buildPermissionSection(
              context,
              title: AppStrings.suppliers,
              icon: Icons.local_shipping,
              permissions: [
                (AppPermissions.viewSuppliers, AppStrings.viewSuppliers),
                (AppPermissions.manageSuppliers, AppStrings.manageSuppliers),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<(String, String)> permissions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: AppDimensions.iconMD, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: AppDimensions.spaceSM),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceSM),
        ...permissions.map((perm) => _buildPermissionCheckbox(context, perm.$1, perm.$2)),
        const SizedBox(height: AppDimensions.spaceMD),
      ],
    );
  }

  Widget _buildPermissionCheckbox(BuildContext context, String permission, String label) {
    final isSelected = _selectedPermissions.contains(permission);

    return CheckboxListTile(
      value: isSelected,
      onChanged: (_) => _togglePermission(permission),
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingSM),
    );
  }
}
