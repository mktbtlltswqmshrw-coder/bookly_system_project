import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/di/injection_container.dart';
import 'package:bookly_system/core/widgets/empty_state_widget.dart';
import 'package:bookly_system/core/widgets/error_widget.dart';
import 'package:bookly_system/core/widgets/loading_widget.dart';
import 'package:bookly_system/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:bookly_system/features/categories/presentation/bloc/categories_event.dart';
import 'package:bookly_system/features/categories/presentation/bloc/categories_state.dart';
import 'package:bookly_system/features/categories/presentation/pages/category_form_page.dart';
import 'package:bookly_system/features/categories/presentation/widgets/category_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحة قائمة الفئات
class CategoriesListPage extends StatelessWidget {
  const CategoriesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoriesBloc>()..add(LoadCategoriesEvent()),
      child: const CategoriesListView(),
    );
  }
}

/// عرض قائمة الفئات
class CategoriesListView extends StatefulWidget {
  const CategoriesListView({super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
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
      context.read<CategoriesBloc>().add(SearchCategoriesEvent(_searchQuery));
    } else {
      context.read<CategoriesBloc>().add(LoadCategoriesEvent());
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
                  hintText: 'البحث في الفئات...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
                onSubmitted: (_) => _performSearch(),
              )
            : const Text(AppStrings.categories),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _searchQuery = '';
                  context.read<CategoriesBloc>().add(LoadCategoriesEvent());
                }
              });
            },
            tooltip: _isSearching ? 'إغلاق البحث' : AppStrings.search,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CategoriesBloc>().add(RefreshCategoriesEvent());
            },
            tooltip: AppStrings.refresh,
          ),
        ],
      ),
      body: Column(
        children: [
          // قائمة الفئات
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoading) {
                  return const LoadingWidget(message: 'جاري تحميل الفئات...');
                } else if (state is CategoriesError) {
                  return CustomErrorWidget(
                    message: state.message,
                    onRetry: () {
                      context.read<CategoriesBloc>().add(LoadCategoriesEvent());
                    },
                  );
                } else if (state is CategoriesLoaded) {
                  if (state.categories.isEmpty) {
                    return const EmptyStateWidget(message: 'لا توجد فئات', icon: Icons.category);
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CategoriesBloc>().add(RefreshCategoriesEvent());
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
                            crossAxisSpacing: AppDimensions.spaceMD,
                            mainAxisSpacing: AppDimensions.spaceMD,
                            childAspectRatio: 0.85, // نسبة عمودية أكبر للفئات
                          ),
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            final category = state.categories[index];
                            return CategoryCardWidget(
                              category: category,
                              onTap: () {
                                // TODO: Navigate to category products
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('منتجات الفئة: ${category.nameAr}'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => CategoryFormPage(category: category)),
                                );
                              },
                              onDelete: () {
                                _showDeleteConfirmation(context, category);
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
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryFormPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text('هل أنت متأكد من حذف الفئة "${category.nameAr}"؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text(AppStrings.cancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<CategoriesBloc>().add(DeleteCategoryEvent(category.id));
            },
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
  }
}
