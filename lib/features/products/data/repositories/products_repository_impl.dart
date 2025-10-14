import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/core/network/network_info.dart';
import 'package:bookly_system/features/products/data/datasources/products_remote_datasource.dart';
import 'package:bookly_system/features/products/domain/entities/product_entity.dart';
import 'package:bookly_system/features/products/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

/// تنفيذ مستودع المنتجات
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId,
    String? searchQuery,
    bool? isActive,
    int? limit,
    int? offset,
  }) async {
    debugPrint('🏪 [ProductsRepository] Starting getProducts call');
    debugPrint(
      '📋 [ProductsRepository] Parameters: categoryId=$categoryId, searchQuery=$searchQuery, isActive=$isActive, limit=$limit, offset=$offset',
    );

    debugPrint('🌐 [ProductsRepository] Checking network connectivity...');
    final isConnected = await networkInfo.isConnected;
    debugPrint('🌐 [ProductsRepository] Network status: $isConnected');

    if (isConnected) {
      debugPrint('✅ [ProductsRepository] Network connected, calling remote data source...');
      try {
        final products = await remoteDataSource.getProducts(
          categoryId: categoryId,
          searchQuery: searchQuery,
          isActive: isActive,
          limit: limit,
          offset: offset,
        );
        debugPrint('✅ [ProductsRepository] Successfully received ${products.length} products from data source');
        return Right(products.map((model) => model as ProductEntity).toList());
      } on ServerException catch (e) {
        debugPrint('❌ [ProductsRepository] ServerException caught: ${e.message}');
        return Left(ServerFailure(e.message));
      } catch (e, stackTrace) {
        debugPrint('❌ [ProductsRepository] Unexpected error: $e');
        debugPrint('📍 [ProductsRepository] Stack trace: $stackTrace');
        return Left(ServerFailure('خطأ غير متوقع: $e'));
      }
    } else {
      debugPrint('❌ [ProductsRepository] No network connection');
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        return Right(product as ProductEntity);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> addProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = await remoteDataSource.addProduct(product as dynamic);
        return Right(productModel as ProductEntity);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = await remoteDataSource.updateProduct(product as dynamic);
        return Right(productModel as ProductEntity);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.searchProducts(query);
        return Right(products.map((model) => model as ProductEntity).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(String categoryId) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProductsByCategory(categoryId);
        return Right(products.map((model) => model as ProductEntity).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getLowStockProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getLowStockProducts();
        return Right(products.map((model) => model as ProductEntity).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProductStock(String productId, int newStock) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.updateProductStock(productId, newStock);
        return Right(product as ProductEntity);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }
}
