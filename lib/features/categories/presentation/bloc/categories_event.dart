import 'package:bookly_system/features/categories/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

/// أحداث الفئات
abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

/// حدث تحميل الفئات
class LoadCategoriesEvent extends CategoriesEvent {
  final String? parentId;
  final bool? isActive;

  const LoadCategoriesEvent({
    this.parentId,
    this.isActive,
  });

  @override
  List<Object?> get props => [parentId, isActive];
}

/// حدث تحديث الفئات
class RefreshCategoriesEvent extends CategoriesEvent {
  const RefreshCategoriesEvent();
}

/// حدث البحث في الفئات
class SearchCategoriesEvent extends CategoriesEvent {
  final String query;

  const SearchCategoriesEvent(this.query);

  @override
  List<Object> get props => [query];
}

/// حدث إضافة فئة
class AddCategoryEvent extends CategoriesEvent {
  final CategoryEntity category;

  const AddCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

/// حدث تحديث فئة
class UpdateCategoryEvent extends CategoriesEvent {
  final CategoryEntity category;

  const UpdateCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

/// حدث حذف فئة
class DeleteCategoryEvent extends CategoriesEvent {
  final String categoryId;

  const DeleteCategoryEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

/// حدث تحميل الفئات الرئيسية
class LoadMainCategoriesEvent extends CategoriesEvent {
  const LoadMainCategoriesEvent();
}

/// حدث تحميل الفئات الفرعية
class LoadSubCategoriesEvent extends CategoriesEvent {
  final String parentId;

  const LoadSubCategoriesEvent(this.parentId);

  @override
  List<Object> get props => [parentId];
}
