import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

/// Widget لتصفية المستخدمين
class UserFilterWidget extends StatelessWidget {
  final UserRole? selectedRole;
  final bool? selectedStatus;
  final void Function(UserRole?) onRoleChanged;
  final void Function(bool?) onStatusChanged;

  const UserFilterWidget({
    super.key,
    this.selectedRole,
    this.selectedStatus,
    required this.onRoleChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.filter,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDimensions.spaceMD),

            // تصفية حسب الدور
            DropdownButtonFormField<UserRole?>(
              initialValue: selectedRole,
              decoration: InputDecoration(
                labelText: AppStrings.role,
                prefixIcon: const Icon(Icons.person_outline),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMD,
                  vertical: AppDimensions.paddingSM,
                ),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('الكل')),
                DropdownMenuItem(value: UserRole.admin, child: Text(UserRole.admin.nameAr)),
                DropdownMenuItem(value: UserRole.employee, child: Text(UserRole.employee.nameAr)),
              ],
              onChanged: onRoleChanged,
            ),
            const SizedBox(height: AppDimensions.spaceMD),

            // تصفية حسب الحالة
            DropdownButtonFormField<bool?>(
              initialValue: selectedStatus,
              decoration: const InputDecoration(
                labelText: 'الحالة',
                prefixIcon: Icon(Icons.toggle_on),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMD,
                  vertical: AppDimensions.paddingSM,
                ),
              ),
              items: const [
                DropdownMenuItem(value: null, child: Text('الكل')),
                DropdownMenuItem(value: true, child: Text('نشط')),
                DropdownMenuItem(value: false, child: Text('غير نشط')),
              ],
              onChanged: onStatusChanged,
            ),
          ],
        ),
      ),
    );
  }
}
