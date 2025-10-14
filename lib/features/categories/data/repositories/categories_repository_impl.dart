import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/core/network/network_info.dart';
import 'package:bookly_system/features/categories/data/datasources/categories_remote_datasource.dart';
import 'package:bookly_system/features/categories/domain/entities/category_entity.dart';
import 'package:bookly_system/features/categories/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

/// تنفيذ مستودع الفئات
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CategoriesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    String? parentId,
    bool? isActive,
    int? limit,
    int? offset,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remoteDataSource.getCategories(
          parentId: parentId,
          isActive: isActive,
          limit: limit,
          offset: offset,
        );
        return Right(categories.map((model) => model as CategoryEntity).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final category = await remoteDataSource.getCategoryById(id);
        return Right(category as CategoryEntity);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> addCategory(CategoryEntity category) async {
    if (await networkInfo.isConnected) {
      try {
        final categoryModel = await remoteDataSource.addCategory(category as dynamic);
        return Right(categoryModel as CategoryEntity);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> updateCategory(CategoryEntity category) async {
    if (await networkInfo.isConnected) {
      try {
        final categoryModel = await remoteDataSource.updateCategory(category as dynamic);
        return Right(categoryModel as CategoryEntity);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteCategory(id);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getMainCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remoteDataSource.getMainCategories();
        return Right(categories.map((model) => model as CategoryEntity).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getSubCategories(String parentId) async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remoteDataSource.getSubCategories(parentId);
        return Right(categories.map((model) => model as CategoryEntity).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> searchCategories(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remoteDataSource.searchCategories(query);
        return Right(categories.map((model) => model as CategoryEntity).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }
}
