import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/features/categories/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

/// Widget لعرض بطاقة الفئة
class CategoryCardWidget extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CategoryCardWidget({super.key, required this.category, this.onTap, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                height: 50, // تصغير من 80 إلى 50
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getCategoryIcon(),
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ), // تصغير حجم الأيقونة
                    const SizedBox(height: 2), // تصغير المسافة
                    Text(
                      'صورة الفئة',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                        fontSize: 10, // تصغير حجم الخط
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6), // تصغير المسافة من spaceMD إلى 6
              // اسم الفئة - تحديد maxLines إلى 1
              Text(
                category.nameAr,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold), // تصغير حجم الخط
                maxLines: 1, // تصغير من 2 إلى 1
                overflow: TextOverflow.ellipsis,
              ),

              // إخفاء الاسم الإنجليزي إذا كان مطابقاً للعربي أو إذا كان طويلاً
              if (category.name != category.nameAr && category.name.length <= 15) ...[
                const SizedBox(height: 2), // تصغير المسافة
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 10, // تصغير حجم الخط
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              const SizedBox(height: 4), // تصغير المسافة
              // الوصف - تبسيط العرض
              if (category.description != null &&
                  category.description!.isNotEmpty &&
                  category.description!.length <= 30) ...[
                Text(
                  category.description!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 9, // تصغير حجم الخط
                  ),
                  maxLines: 1, // تصغير من 2 إلى 1
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4), // تصغير المسافة
              ] else ...[
                const SizedBox(height: 4), // إضافة مسافة ثابتة
              ],

              // حالة النشاط والأزرار - تبسيط التصميم
              Row(
                children: [
                  // حالة النشاط - تبسيط التصميم
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // تصغير padding
                      decoration: BoxDecoration(
                        color: category.isActive
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category.isActive ? Icons.check_circle : Icons.cancel,
                            size: 12, // تصغير حجم الأيقونة
                            color: category.isActive
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 2), // تصغير المسافة
                          Text(
                            category.isActive ? 'نشط' : 'غير نشط',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: category.isActive
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 9, // تصغير حجم الخط
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // أزرار الإجراءات - تصغير الحجم
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
                          color: Theme.of(context).colorScheme.error,
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

  IconData _getCategoryIcon() {
    // تحديد الأيقونة حسب نوع الفئة أو الأيقونة المحفوظة
    if (category.icon != null) {
      switch (category.icon) {
        case 'school':
          return Icons.school;
        case 'work':
          return Icons.work;
        case 'palette':
          return Icons.palette;
        case 'menu_book':
          return Icons.menu_book;
        case 'computer':
          return Icons.computer;
        case 'edit':
          return Icons.edit;
        case 'book':
          return Icons.book;
        default:
          return Icons.category;
      }
    }

    // تحديد الأيقونة حسب الاسم
    final nameAr = category.nameAr.toLowerCase();
    if (nameAr.contains('مدرس') || nameAr.contains('مدرسة')) {
      return Icons.school;
    } else if (nameAr.contains('مكتب') || nameAr.contains('عمل')) {
      return Icons.work;
    } else if (nameAr.contains('فن') || nameAr.contains('رسم')) {
      return Icons.palette;
    } else if (nameAr.contains('كتاب') || nameAr.contains('مرجع')) {
      return Icons.menu_book;
    } else if (nameAr.contains('حاسوب') || nameAr.contains('إلكترون')) {
      return Icons.computer;
    } else if (nameAr.contains('دفتر') || nameAr.contains('مذكرة')) {
      return Icons.book;
    } else {
      return Icons.category;
    }
  }
}
