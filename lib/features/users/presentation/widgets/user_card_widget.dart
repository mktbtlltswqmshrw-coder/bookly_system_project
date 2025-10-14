import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/utils/formatters.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/presentation/widgets/user_role_badge_widget.dart';
import 'package:flutter/material.dart';

/// كارد عرض المستخدم
class UserCardWidget extends StatelessWidget {
  final UserEntity user;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleStatus;
  final VoidCallback? onManagePermissions;

  const UserCardWidget({
    super.key,
    required this.user,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onToggleStatus,
    this.onManagePermissions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMD, vertical: AppDimensions.paddingSM),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الصف الأول: الاسم والدور
              Row(
                children: [
                  // الصورة الشخصية
                  CircleAvatar(
                    radius: AppDimensions.imageAvatarMD / 2,
                    backgroundColor: user.isActive
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                        : AppColors.textDisabledLight.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      color: user.isActive ? Theme.of(context).colorScheme.primary : AppColors.textDisabledLight,
                      size: AppDimensions.iconMD,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spaceMD),

                  // الاسم والبريد
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: user.isActive ? null : AppColors.textSecondaryLight,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceXS),
                        Text(
                          user.email,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryLight),
                        ),
                      ],
                    ),
                  ),

                  // Badge الدور
                  UserRoleBadgeWidget(role: user.role),
                ],
              ),

              // الفاصل
              if (user.phone != null || !user.isActive) ...[
                const SizedBox(height: AppDimensions.spaceSM),
                const Divider(height: 1),
                const SizedBox(height: AppDimensions.spaceSM),
              ],

              // الصف الثاني: الهاتف والحالة
              Row(
                children: [
                  if (user.phone != null) ...[
                    Icon(Icons.phone, size: AppDimensions.iconSM, color: AppColors.textSecondaryLight),
                    const SizedBox(width: AppDimensions.spaceXS),
                    Text(Formatters.formatIraqiPhone(user.phone!), style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: AppDimensions.spaceMD),
                  ],

                  // الحالة
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingSM,
                      vertical: AppDimensions.paddingXS,
                    ),
                    decoration: BoxDecoration(
                      color: user.isActive ? AppColors.success.withOpacity(0.1) : AppColors.errorLight.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          user.isActive ? Icons.check_circle : Icons.cancel,
                          size: AppDimensions.iconSM,
                          color: user.isActive ? AppColors.success : AppColors.errorLight,
                        ),
                        const SizedBox(width: AppDimensions.spaceXS),
                        Text(
                          user.isActive ? AppStrings.active : AppStrings.inactive,
                          style: TextStyle(
                            color: user.isActive ? AppColors.success : AppColors.errorLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // التاريخ
                  Text(
                    Formatters.formatRelativeDate(user.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryLight),
                  ),
                ],
              ),

              // الصف الثالث: الأزرار
              if (onEdit != null || onDelete != null || onToggleStatus != null || onManagePermissions != null) ...[
                const SizedBox(height: AppDimensions.spaceSM),
                const Divider(height: 1),
                const SizedBox(height: AppDimensions.spaceSM),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onManagePermissions != null && user.role == UserRole.employee)
                      Tooltip(
                        message: AppStrings.managePermissions,
                        child: IconButton(
                          icon: const Icon(Icons.security, size: AppDimensions.iconMD),
                          onPressed: onManagePermissions,
                          color: AppColors.info,
                        ),
                      ),
                    if (onToggleStatus != null) ...[
                      const SizedBox(width: AppDimensions.spaceSM),
                      Tooltip(
                        message: user.isActive ? AppStrings.deactivateUser : AppStrings.activateUser,
                        child: IconButton(
                          icon: Icon(user.isActive ? Icons.block : Icons.check_circle, size: AppDimensions.iconMD),
                          onPressed: onToggleStatus,
                          color: user.isActive ? AppColors.warning : AppColors.success,
                        ),
                      ),
                    ],
                    if (onEdit != null) ...[
                      const SizedBox(width: AppDimensions.spaceSM),
                      Tooltip(
                        message: AppStrings.edit,
                        child: IconButton(
                          icon: const Icon(Icons.edit, size: AppDimensions.iconMD),
                          onPressed: onEdit,
                          color: AppColors.info,
                        ),
                      ),
                    ],
                    if (onDelete != null) ...[
                      const SizedBox(width: AppDimensions.spaceSM),
                      Tooltip(
                        message: AppStrings.delete,
                        child: IconButton(
                          icon: const Icon(Icons.delete, size: AppDimensions.iconMD),
                          onPressed: onDelete,
                          color: AppColors.errorLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
