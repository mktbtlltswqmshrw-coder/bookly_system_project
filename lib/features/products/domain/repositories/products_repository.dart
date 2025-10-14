import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/products/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

/// واجهة مستودع المنتجات
abstract class ProductsRepository {
  /// الحصول على جميع المنتجات
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId,
    String? searchQuery,
    bool? isActive,
    int? limit,
    int? offset,
  });

  /// الحصول على منتج بالمعرف
  Future<Either<Failure, ProductEntity>> getProductById(String id);

  /// إضافة منتج جديد
  Future<Either<Failure, ProductEntity>> addProduct(ProductEntity product);

  /// تحديث منتج موجود
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);

  /// حذف منتج
  Future<Either<Failure, Unit>> deleteProduct(String id);

  /// البحث في المنتجات
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);

  /// الحصول على منتجات فئة معينة
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(String categoryId);

  /// الحصول على منتجات المخزون المنخفض
  Future<Either<Failure, List<ProductEntity>>> getLowStockProducts();

  /// تحديث مخزون منتج
  Future<Either<Failure, ProductEntity>> updateProductStock(String productId, int newStock);
}
