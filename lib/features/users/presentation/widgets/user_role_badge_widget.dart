import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

/// Badge يعرض دور المستخدم
class UserRoleBadgeWidget extends StatelessWidget {
  final UserRole role;
  final bool isCompact;

  const UserRoleBadgeWidget({super.key, required this.role, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    final isAdmin = role == UserRole.admin;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? AppDimensions.paddingSM : AppDimensions.paddingMD,
        vertical: isCompact ? AppDimensions.paddingXS : AppDimensions.paddingSM,
      ),
      decoration: BoxDecoration(
        color: isAdmin ? AppColors.primaryLight.withOpacity(0.1) : AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
        border: Border.all(color: isAdmin ? AppColors.primaryLight : AppColors.info, width: AppDimensions.borderThin),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAdmin ? Icons.admin_panel_settings : Icons.person,
            size: isCompact ? AppDimensions.iconSM : AppDimensions.iconMD,
            color: isAdmin ? AppColors.primaryLight : AppColors.info,
          ),
          if (!isCompact) ...[
            const SizedBox(width: AppDimensions.spaceXS),
            Text(
              role.nameAr,
              style: TextStyle(
                color: isAdmin ? AppColors.primaryLight : AppColors.info,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
