import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/categories/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

/// Use Case لحذف فئة
class DeleteCategoryUseCase {
  final CategoriesRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteCategory(id);
  }
}
