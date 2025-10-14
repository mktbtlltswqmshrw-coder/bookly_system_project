import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/categories/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';

/// واجهة مستودع الفئات
abstract class CategoriesRepository {
  /// الحصول على جميع الفئات
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    String? parentId,
    bool? isActive,
    int? limit,
    int? offset,
  });

  /// الحصول على فئة بالمعرف
  Future<Either<Failure, CategoryEntity>> getCategoryById(String id);

  /// إضافة فئة جديدة
  Future<Either<Failure, CategoryEntity>> addCategory(CategoryEntity category);

  /// تحديث فئة موجودة
  Future<Either<Failure, CategoryEntity>> updateCategory(CategoryEntity category);

  /// حذف فئة
  Future<Either<Failure, Unit>> deleteCategory(String id);

  /// الحصول على الفئات الرئيسية فقط
  Future<Either<Failure, List<CategoryEntity>>> getMainCategories();

  /// الحصول على الفئات الفرعية لفئة معينة
  Future<Either<Failure, List<CategoryEntity>>> getSubCategories(String parentId);

  /// البحث في الفئات
  Future<Either<Failure, List<CategoryEntity>>> searchCategories(String query);
}
