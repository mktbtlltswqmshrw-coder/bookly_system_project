import 'package:bookly_system/core/usecases/usecase.dart';
import 'package:bookly_system/features/products/domain/usecases/get_products_usecase.dart';
import 'package:bookly_system/features/products/presentation/bloc/products_event.dart';
import 'package:bookly_system/features/products/presentation/bloc/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc للمنتجات
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final GetLowStockProductsUseCase getLowStockProductsUseCase;
  final UpdateProductStockUseCase updateProductStockUseCase;

  ProductsBloc({
    required this.getProductsUseCase,
    required this.getProductByIdUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    required this.searchProductsUseCase,
    required this.getLowStockProductsUseCase,
    required this.updateProductStockUseCase,
  }) : super(ProductsInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<RefreshProductsEvent>(_onRefreshProducts);
    on<SearchProductsEvent>(_onSearchProducts);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<UpdateProductStockEvent>(_onUpdateProductStock);
    on<LoadLowStockProductsEvent>(_onLoadLowStockProducts);
    on<LoadProductsByCategoryEvent>(_onLoadProductsByCategory);
  }

  /// معالج تحميل المنتجات
  Future<void> _onLoadProducts(LoadProductsEvent event, Emitter<ProductsState> emit) async {
    emit(const ProductsLoading());

    final result = await getProductsUseCase(
      GetProductsParams(categoryId: event.categoryId, searchQuery: event.searchQuery, isActive: event.isActive),
    );

    result.fold((failure) => emit(ProductsError(failure.message)), (products) => emit(ProductsLoaded(products)));
  }

  /// معالج تحديث المنتجات
  Future<void> _onRefreshProducts(RefreshProductsEvent event, Emitter<ProductsState> emit) async {
    emit(const ProductsLoading());

    final result = await getProductsUseCase(const GetProductsParams());

    result.fold((failure) => emit(ProductsError(failure.message)), (products) => emit(ProductsLoaded(products)));
  }

  /// معالج البحث في المنتجات
  Future<void> _onSearchProducts(SearchProductsEvent event, Emitter<ProductsState> emit) async {
    emit(const ProductsLoading());

    final result = await searchProductsUseCase(event.query);

    result.fold((failure) => emit(ProductsError(failure.message)), (products) => emit(ProductsLoaded(products)));
  }

  /// معالج إضافة منتج
  Future<void> _onAddProduct(AddProductEvent event, Emitter<ProductsState> emit) async {
    final result = await addProductUseCase(event.product);

    result.fold((failure) => emit(ProductsError(failure.message)), (product) => emit(ProductAdded(product)));
  }

  /// معالج تحديث منتج
  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<ProductsState> emit) async {
    final result = await updateProductUseCase(event.product);

    result.fold((failure) => emit(ProductsError(failure.message)), (product) => emit(ProductUpdated(product)));
  }

  /// معالج حذف منتج
  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductsState> emit) async {
    final result = await deleteProductUseCase(event.productId);

    result.fold((failure) => emit(ProductsError(failure.message)), (_) => emit(ProductDeleted(event.productId)));
  }

  /// معالج تحديث مخزون منتج
  Future<void> _onUpdateProductStock(UpdateProductStockEvent event, Emitter<ProductsState> emit) async {
    final result = await updateProductStockUseCase(
      UpdateStockParams(productId: event.productId, newStock: event.newStock),
    );

    result.fold((failure) => emit(ProductsError(failure.message)), (product) => emit(ProductStockUpdated(product)));
  }

  /// معالج تحميل منتجات المخزون المنخفض
  Future<void> _onLoadLowStockProducts(LoadLowStockProductsEvent event, Emitter<ProductsState> emit) async {
    emit(const ProductsLoading());

    final result = await getLowStockProductsUseCase(NoParams());

    result.fold((failure) => emit(ProductsError(failure.message)), (products) => emit(ProductsLoaded(products)));
  }

  /// معالج تحميل منتجات فئة معينة
  Future<void> _onLoadProductsByCategory(LoadProductsByCategoryEvent event, Emitter<ProductsState> emit) async {
    emit(const ProductsLoading());

    final result = await getProductsUseCase(GetProductsParams(categoryId: event.categoryId, isActive: true));

    result.fold((failure) => emit(ProductsError(failure.message)), (products) => emit(ProductsLoaded(products)));
  }
}
