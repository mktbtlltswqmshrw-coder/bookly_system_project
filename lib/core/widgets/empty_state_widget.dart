import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

/// ويدجت الحالة الفارغة
class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? description;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionText;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.description,
    this.icon,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon ?? Icons.inbox_outlined, size: AppDimensions.iconXXL * 1.5, color: AppColors.textSecondaryLight),
            const SizedBox(height: AppDimensions.spaceLG),
            Text(
              message,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textPrimaryLight),
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              const SizedBox(height: AppDimensions.spaceSM),
              Text(
                description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondaryLight),
                textAlign: TextAlign.center,
              ),
            ],
            if (onAction != null) ...[
              const SizedBox(height: AppDimensions.spaceLG),
              CustomButton(text: actionText ?? 'إضافة', onPressed: onAction, icon: Icons.add),
            ],
          ],
        ),
      ),
    );
  }
}

/// ويدجت حالة فارغة صغيرة
class SmallEmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData? icon;

  const SmallEmptyStateWidget({super.key, required this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? Icons.inbox_outlined, size: AppDimensions.iconLG, color: AppColors.textSecondaryLight),
            const SizedBox(height: AppDimensions.spaceSM),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondaryLight),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
