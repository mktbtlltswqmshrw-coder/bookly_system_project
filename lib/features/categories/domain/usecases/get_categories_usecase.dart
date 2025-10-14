import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/core/usecases/usecase.dart';
import 'package:bookly_system/features/categories/domain/entities/category_entity.dart';
import 'package:bookly_system/features/categories/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

/// Use Case للحصول على جميع الفئات
class GetCategoriesUseCase implements UseCase<List<CategoryEntity>, GetCategoriesParams> {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(GetCategoriesParams params) async {
    return await repository.getCategories(
      parentId: params.parentId,
      isActive: params.isActive,
      limit: params.limit,
      offset: params.offset,
    );
  }
}

/// معاملات الحصول على الفئات
class GetCategoriesParams {
  final String? parentId;
  final bool? isActive;
  final int? limit;
  final int? offset;

  const GetCategoriesParams({this.parentId, this.isActive, this.limit, this.offset});
}

/// Use Case للحصول على فئة بالمعرف
class GetCategoryByIdUseCase implements UseCase<CategoryEntity, String> {
  final CategoriesRepository repository;

  GetCategoryByIdUseCase(this.repository);

  @override
  Future<Either<Failure, CategoryEntity>> call(String categoryId) async {
    return await repository.getCategoryById(categoryId);
  }
}

/// Use Case لإضافة فئة جديدة
class AddCategoryUseCase implements UseCase<CategoryEntity, CategoryEntity> {
  final CategoriesRepository repository;

  AddCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, CategoryEntity>> call(CategoryEntity category) async {
    return await repository.addCategory(category);
  }
}

/// Use Case لتحديث فئة موجودة
class UpdateCategoryUseCase implements UseCase<CategoryEntity, CategoryEntity> {
  final CategoriesRepository repository;

  UpdateCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, CategoryEntity>> call(CategoryEntity category) async {
    return await repository.updateCategory(category);
  }
}

/// Use Case لحذف فئة
class DeleteCategoryUseCase implements UseCase<Unit, String> {
  final CategoriesRepository repository;

  DeleteCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String categoryId) async {
    return await repository.deleteCategory(categoryId);
  }
}

/// Use Case للحصول على الفئات الرئيسية
class GetMainCategoriesUseCase implements UseCase<List<CategoryEntity>, NoParams> {
  final CategoriesRepository repository;

  GetMainCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.getMainCategories();
  }
}

/// Use Case للحصول على الفئات الفرعية
class GetSubCategoriesUseCase implements UseCase<List<CategoryEntity>, String> {
  final CategoriesRepository repository;

  GetSubCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(String parentId) async {
    return await repository.getSubCategories(parentId);
  }
}

/// Use Case للبحث في الفئات
class SearchCategoriesUseCase implements UseCase<List<CategoryEntity>, String> {
  final CategoriesRepository repository;

  SearchCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(String query) async {
    return await repository.searchCategories(query);
  }
}
