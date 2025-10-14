import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

/// ويدجت عرض الخطأ
class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const CustomErrorWidget({super.key, required this.message, this.onRetry, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon ?? Icons.error_outline, size: AppDimensions.iconXXL, color: AppColors.errorLight),
            const SizedBox(height: AppDimensions.spaceLG),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.errorLight),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.spaceLG),
              CustomButton(
                text: 'إعادة المحاولة',
                onPressed: onRetry,
                icon: Icons.refresh,
                backgroundColor: AppColors.errorLight,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// ويدجت خطأ صغير
class SmallErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const SmallErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: AppDimensions.iconLG, color: AppColors.errorLight),
            const SizedBox(height: AppDimensions.spaceSM),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.errorLight),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.spaceSM),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: AppDimensions.iconSM),
                label: const Text('إعادة'),
                style: TextButton.styleFrom(foregroundColor: AppColors.errorLight),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
