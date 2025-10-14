import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/core/usecases/usecase.dart';
import 'package:bookly_system/features/products/domain/entities/product_entity.dart';
import 'package:bookly_system/features/products/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

/// Use Case للحصول على جميع المنتجات
class GetProductsUseCase implements UseCase<List<ProductEntity>, GetProductsParams> {
  final ProductsRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetProductsParams params) async {
    return await repository.getProducts(
      categoryId: params.categoryId,
      searchQuery: params.searchQuery,
      isActive: params.isActive,
      limit: params.limit,
      offset: params.offset,
    );
  }
}

/// معاملات الحصول على المنتجات
class GetProductsParams {
  final String? categoryId;
  final String? searchQuery;
  final bool? isActive;
  final int? limit;
  final int? offset;

  const GetProductsParams({this.categoryId, this.searchQuery, this.isActive, this.limit, this.offset});
}

/// Use Case للحصول على منتج بالمعرف
class GetProductByIdUseCase implements UseCase<ProductEntity, String> {
  final ProductsRepository repository;

  GetProductByIdUseCase(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(String productId) async {
    return await repository.getProductById(productId);
  }
}

/// Use Case لإضافة منتج جديد
class AddProductUseCase implements UseCase<ProductEntity, ProductEntity> {
  final ProductsRepository repository;

  AddProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(ProductEntity product) async {
    return await repository.addProduct(product);
  }
}

/// Use Case لتحديث منتج موجود
class UpdateProductUseCase implements UseCase<ProductEntity, ProductEntity> {
  final ProductsRepository repository;

  UpdateProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(ProductEntity product) async {
    return await repository.updateProduct(product);
  }
}

/// Use Case لحذف منتج
class DeleteProductUseCase implements UseCase<Unit, String> {
  final ProductsRepository repository;

  DeleteProductUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String productId) async {
    return await repository.deleteProduct(productId);
  }
}

/// Use Case للبحث في المنتجات
class SearchProductsUseCase implements UseCase<List<ProductEntity>, String> {
  final ProductsRepository repository;

  SearchProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(String query) async {
    return await repository.searchProducts(query);
  }
}

/// Use Case للحصول على منتجات المخزون المنخفض
class GetLowStockProductsUseCase implements UseCase<List<ProductEntity>, NoParams> {
  final ProductsRepository repository;

  GetLowStockProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await repository.getLowStockProducts();
  }
}

/// Use Case لتحديث مخزون منتج
class UpdateProductStockUseCase implements UseCase<ProductEntity, UpdateStockParams> {
  final ProductsRepository repository;

  UpdateProductStockUseCase(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(UpdateStockParams params) async {
    return await repository.updateProductStock(params.productId, params.newStock);
  }
}

/// معاملات تحديث المخزون
class UpdateStockParams {
  final String productId;
  final int newStock;

  UpdateStockParams({required this.productId, required this.newStock});
}
