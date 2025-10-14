import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/di/injection_container.dart';
import 'package:bookly_system/core/widgets/empty_state_widget.dart';
import 'package:bookly_system/core/widgets/error_widget.dart';
import 'package:bookly_system/core/widgets/loading_widget.dart';
import 'package:bookly_system/features/products/presentation/bloc/products_bloc.dart';
import 'package:bookly_system/features/products/presentation/bloc/products_event.dart';
import 'package:bookly_system/features/products/presentation/bloc/products_state.dart';
import 'package:bookly_system/features/products/presentation/pages/product_form_page.dart';
import 'package:bookly_system/features/products/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحة قائمة المنتجات
class ProductsListPage extends StatelessWidget {
  const ProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🏗️ [ProductsListPage] Building ProductsListPage');
    debugPrint('🏗️ [ProductsListPage] Creating BlocProvider with ProductsBloc');
    debugPrint('🏗️ [ProductsListPage] Adding LoadProductsEvent to trigger initial load');

    return BlocProvider(
      create: (_) {
        debugPrint('🏗️ [ProductsListPage] Creating new ProductsBloc instance');
        final bloc = getIt<ProductsBloc>();
        debugPrint('🏗️ [ProductsListPage] Adding LoadProductsEvent to the bloc');
        bloc.add(LoadProductsEvent());
        return bloc;
      },
      child: const ProductsListView(),
    );
  }
}

/// عرض قائمة المنتجات
class ProductsListView extends StatefulWidget {
  const ProductsListView({super.key});

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    if (_searchQuery.isNotEmpty) {
      context.read<ProductsBloc>().add(SearchProductsEvent(_searchQuery));
    } else {
      context.read<ProductsBloc>().add(LoadProductsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'البحث في المنتجات...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
                onSubmitted: (_) => _performSearch(),
              )
            : const Text(AppStrings.products),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _searchQuery = '';
                  context.read<ProductsBloc>().add(LoadProductsEvent());
                }
              });
            },
            tooltip: _isSearching ? 'إغلاق البحث' : AppStrings.search,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ProductsBloc>().add(RefreshProductsEvent());
            },
            tooltip: AppStrings.refresh,
          ),
        ],
      ),
      body: Column(
        children: [
          // قائمة المنتجات
          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                debugPrint('🎨 [ProductsListView] BlocBuilder rebuilding with state: ${state.runtimeType}');

                if (state is ProductsLoading) {
                  debugPrint('⏳ [ProductsListView] Displaying loading state');
                  return const LoadingWidget(message: 'جاري تحميل المنتجات...');
                } else if (state is ProductsError) {
                  debugPrint('❌ [ProductsListView] Displaying error state: ${state.message}');
                  return CustomErrorWidget(
                    message: state.message,
                    onRetry: () {
                      debugPrint('🔄 [ProductsListView] Retry button pressed, triggering LoadProductsEvent');
                      context.read<ProductsBloc>().add(LoadProductsEvent());
                    },
                  );
                } else if (state is ProductsLoaded) {
                  debugPrint('✅ [ProductsListView] Displaying loaded state with ${state.products.length} products');
                  if (state.products.isEmpty) {
                    debugPrint('📭 [ProductsListView] Products list is empty, showing empty state');
                    return const EmptyStateWidget(message: 'لا توجد منتجات', icon: Icons.inventory);
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProductsBloc>().add(RefreshProductsEvent());
                      await Future.delayed(const Duration(seconds: 1));
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // تحديد عدد الأعمدة حسب عرض الشاشة
                        int crossAxisCount = 2; // عنصرين على الموبايل (الشاشات الصغيرة)
                        if (constraints.maxWidth >= 900) crossAxisCount = 3; // 3 أعمدة على الشاشات المتوسطة
                        if (constraints.maxWidth >= 1200) crossAxisCount = 4; // 4 أعمدة على الشاشات الكبيرة

                        return GridView.builder(
                          padding: const EdgeInsets.all(AppDimensions.paddingMD),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 0.65, // نسبة عمودية أكبر للمنتجات
                            crossAxisSpacing: AppDimensions.spaceMD,
                            mainAxisSpacing: AppDimensions.spaceMD,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCardWidget(
                              product: product,
                              onTap: () {
                                // TODO: Navigate to product details
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تفاصيل المنتج: ${product.nameAr}'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ProductFormPage(product: product)),
                                );
                              },
                              onDelete: () {
                                _showDeleteConfirmation(context, product);
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductFormPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text('هل أنت متأكد من حذف المنتج "${product.nameAr}"؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text(AppStrings.cancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProductsBloc>().add(DeleteProductEvent(product.id));
            },
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
  }
}
