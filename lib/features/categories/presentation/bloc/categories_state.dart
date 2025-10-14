import 'package:bookly_system/features/categories/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

/// حالات الفئات
abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

/// الحالة الأولية
class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();
}

/// حالة التحميل
class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

/// حالة تحميل الفئات بنجاح
class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> categories;

  const CategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

/// حالة الخطأ
class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError(this.message);

  @override
  List<Object> get props => [message];
}

/// حالة إضافة فئة بنجاح
class CategoryAdded extends CategoriesState {
  final CategoryEntity category;

  const CategoryAdded(this.category);

  @override
  List<Object> get props => [category];
}

/// حالة تحديث فئة بنجاح
class CategoryUpdated extends CategoriesState {
  final CategoryEntity category;

  const CategoryUpdated(this.category);

  @override
  List<Object> get props => [category];
}

/// حالة حذف فئة بنجاح
class CategoryDeleted extends CategoriesState {
  final String categoryId;

  const CategoryDeleted(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
