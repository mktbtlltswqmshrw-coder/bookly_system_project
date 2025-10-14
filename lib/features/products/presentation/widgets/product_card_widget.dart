import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/utils/formatters.dart';
import 'package:bookly_system/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

/// Widget لعرض بطاقة المنتج
class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductCardWidget({super.key, required this.product, this.onTap, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceMD),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(8.0), // تصغير padding من paddingMD إلى 8.0
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // مساحة الصورة (placeholder حالياً) - تصغير الارتفاع
              Container(
                width: double.infinity,
                height: 80, // تصغير من 120 إلى 80
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 24, // تصغير من iconXL إلى 24
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                    ),
                    const SizedBox(height: 2), // تصغير المسافة
                    Text(
                      'صورة المنتج',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                        fontSize: 10, // تصغير حجم الخط
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6), // تصغير المسافة من spaceMD إلى 6
              // اسم المنتج - تحديد maxLines إلى 1
              Text(
                product.nameAr,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold), // تصغير حجم الخط
                maxLines: 1, // تصغير من 2 إلى 1
                overflow: TextOverflow.ellipsis,
              ),

              // إخفاء الاسم الإنجليزي إذا كان مطابقاً للعربي أو إذا كان طويلاً
              if (product.name != product.nameAr && product.name.length <= 20) ...[
                const SizedBox(height: 2), // تصغير المسافة
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 10, // تصغير حجم الخط
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              const SizedBox(height: 4), // تصغير المسافة
              // السعر - تبسيط التصميم
              Row(
                children: [
                  Expanded(
                    child: Text(
                      Formatters.formatCurrency(product.sellingPrice),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        // تصغير حجم الخط
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                        fontSize: 12, // تصغير حجم الخط
                      ),
                    ),
                  ),
                  if (product.costPrice > 0)
                    Text(
                      'تكلفة: ${Formatters.formatCurrency(product.costPrice)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        fontSize: 9, // تصغير حجم الخط
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 4), // تصغير المسافة
              // معلومات إضافية (SKU والمخزون) - تبسيط التصميم
              Row(
                children: [
                  if (product.sku != null && product.sku!.length <= 10) ...[
                    Expanded(
                      child: _buildInfoChip(context, icon: Icons.qr_code, label: 'SKU', value: product.sku!),
                    ),
                    const SizedBox(width: 4), // تصغير المسافة
                  ],
                  Expanded(
                    child: _buildInfoChip(
                      context,
                      icon: Icons.inventory,
                      label: 'المخزون',
                      value: '${product.currentStock} ${product.unit}',
                      color: product.isLowStock ? AppColors.warning : AppColors.success,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4), // تصغير المسافة
              // حالة المخزون والأزرار - تبسيط التصميم
              Row(
                children: [
                  Expanded(child: _buildStockStatus(context)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (onEdit != null)
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: onEdit,
                          tooltip: AppStrings.edit,
                          iconSize: 16, // تصغير حجم الأيقونة
                          padding: const EdgeInsets.all(2), // تصغير padding
                          constraints: const BoxConstraints(minWidth: 24, minHeight: 24), // تصغير الحد الأدنى
                        ),
                      if (onDelete != null)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: onDelete,
                          tooltip: AppStrings.delete,
                          iconSize: 16, // تصغير حجم الأيقونة
                          padding: const EdgeInsets.all(2), // تصغير padding
                          constraints: const BoxConstraints(minWidth: 24, minHeight: 24), // تصغير الحد الأدنى
                          color: AppColors.errorLight,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // تصغير padding
      decoration: BoxDecoration(
        color: (color ?? Theme.of(context).colorScheme.primary).withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
        border: Border.all(color: (color ?? Theme.of(context).colorScheme.primary).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color ?? Theme.of(context).colorScheme.primary), // تصغير حجم الأيقونة
          const SizedBox(width: 2), // تصغير المسافة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 8, // تصغير حجم الخط
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color ?? Theme.of(context).colorScheme.primary,
                    fontSize: 9, // تصغير حجم الخط
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockStatus(BuildContext context) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    if (product.isOutOfStock) {
      statusColor = AppColors.errorLight;
      statusText = 'نفذ من المخزون';
      statusIcon = Icons.error;
    } else if (product.isLowStock) {
      statusColor = AppColors.warning;
      statusText = 'مخزون منخفض';
      statusIcon = Icons.warning;
    } else {
      statusColor = AppColors.success;
      statusText = 'متوفر';
      statusIcon = Icons.check_circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // تصغير padding
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 12, color: statusColor), // تصغير حجم الأيقونة
          const SizedBox(width: 2), // تصغير المسافة
          Text(
            statusText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 9, // تصغير حجم الخط
            ),
          ),
        ],
      ),
    );
  }
}
