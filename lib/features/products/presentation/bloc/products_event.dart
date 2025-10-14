import 'package:bookly_system/features/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

/// أحداث المنتجات
abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

/// حدث تحميل المنتجات
class LoadProductsEvent extends ProductsEvent {
  final String? categoryId;
  final String? searchQuery;
  final bool? isActive;

  const LoadProductsEvent({this.categoryId, this.searchQuery, this.isActive});

  @override
  List<Object?> get props => [categoryId, searchQuery, isActive];
}

/// حدث تحديث المنتجات
class RefreshProductsEvent extends ProductsEvent {
  const RefreshProductsEvent();
}

/// حدث البحث في المنتجات
class SearchProductsEvent extends ProductsEvent {
  final String query;

  const SearchProductsEvent(this.query);

  @override
  List<Object> get props => [query];
}

/// حدث إضافة منتج
class AddProductEvent extends ProductsEvent {
  final ProductEntity product;

  const AddProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

/// حدث تحديث منتج
class UpdateProductEvent extends ProductsEvent {
  final ProductEntity product;

  const UpdateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

/// حدث حذف منتج
class DeleteProductEvent extends ProductsEvent {
  final String productId;

  const DeleteProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

/// حدث تحديث مخزون منتج
class UpdateProductStockEvent extends ProductsEvent {
  final String productId;
  final int newStock;

  const UpdateProductStockEvent({required this.productId, required this.newStock});

  @override
  List<Object> get props => [productId, newStock];
}

/// حدث تحميل منتجات المخزون المنخفض
class LoadLowStockProductsEvent extends ProductsEvent {
  const LoadLowStockProductsEvent();
}

/// حدث تحميل منتجات فئة معينة
class LoadProductsByCategoryEvent extends ProductsEvent {
  final String categoryId;

  const LoadProductsByCategoryEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
