import 'package:bookly_system/features/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

/// حالات المنتجات
abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

/// الحالة الأولية
class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

/// حالة التحميل
class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

/// حالة تحميل المنتجات بنجاح
class ProductsLoaded extends ProductsState {
  final List<ProductEntity> products;

  const ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

/// حالة الخطأ
class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object> get props => [message];
}

/// حالة إضافة منتج بنجاح
class ProductAdded extends ProductsState {
  final ProductEntity product;

  const ProductAdded(this.product);

  @override
  List<Object> get props => [product];
}

/// حالة تحديث منتج بنجاح
class ProductUpdated extends ProductsState {
  final ProductEntity product;

  const ProductUpdated(this.product);

  @override
  List<Object> get props => [product];
}

/// حالة حذف منتج بنجاح
class ProductDeleted extends ProductsState {
  final String productId;

  const ProductDeleted(this.productId);

  @override
  List<Object> get props => [productId];
}

/// حالة تحديث مخزون منتج بنجاح
class ProductStockUpdated extends ProductsState {
  final ProductEntity product;

  const ProductStockUpdated(this.product);

  @override
  List<Object> get props => [product];
}
