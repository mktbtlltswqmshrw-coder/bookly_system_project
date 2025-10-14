import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:bookly_system/core/constants/app_strings.dart';
import 'package:bookly_system/core/di/injection_container.dart';
import 'package:bookly_system/core/utils/formatters.dart';
import 'package:bookly_system/core/widgets/error_widget.dart';
import 'package:bookly_system/core/widgets/loading_widget.dart';
import 'package:bookly_system/features/auth/presentation/pages/login_page.dart';
import 'package:bookly_system/features/categories/presentation/pages/categories_list_page.dart';
import 'package:bookly_system/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:bookly_system/features/dashboard/presentation/widgets/stats_card_widget.dart';
import 'package:bookly_system/features/products/presentation/pages/products_list_page.dart';
import 'package:bookly_system/features/settings/presentation/pages/settings_page.dart';
import 'package:bookly_system/features/users/presentation/pages/users_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحة لوحة التحكم
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardBloc>()..add(const LoadDashboardStatsEvent()),
      child: const DashboardView(),
    );
  }
}

/// عرض لوحة التحكم
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _DashboardContent(),
    const UsersListPage(),
    const CategoriesListPage(), // بدلاً من placeholder
    const ProductsListPage(), // بدلاً من placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _DashboardDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          debugPrint('🎯 [DashboardPage] Bottom navigation tapped: $index');
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'لوحة التحكم'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'المستخدمين'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'الفئات'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'المنتجات'),
        ],
      ),
    );
  }
}

/// محتوى لوحة التحكم الرئيسية
class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.dashboard),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to users page
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UsersListPage()));
            },
            tooltip: AppStrings.users,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<DashboardBloc>().add(const RefreshDashboardStatsEvent());
            },
            tooltip: AppStrings.refresh,
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const LoadingWidget(message: 'جاري تحميل الإحصائيات...');
          } else if (state is DashboardError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<DashboardBloc>().add(const LoadDashboardStatsEvent());
              },
            );
          } else if (state is DashboardStatsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(const RefreshDashboardStatsEvent());
                await Future.delayed(const Duration(seconds: 1));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppDimensions.paddingLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان
                    Text(
                      AppStrings.overview,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDimensions.spaceLG),

                    // Grid الإحصائيات
                    LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 2;
                        if (constraints.maxWidth > 900) {
                          crossAxisCount = 3;
                        }
                        if (constraints.maxWidth > 1200) {
                          crossAxisCount = 4;
                        }

                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: AppDimensions.spaceMD,
                          crossAxisSpacing: AppDimensions.spaceMD,
                          childAspectRatio: 1.2,
                          children: [
                            StatsCardWidget(
                              title: AppStrings.totalProducts,
                              value: state.stats.totalProducts.toString(),
                              icon: Icons.inventory,
                              color: AppColors.primaryLight,
                            ),
                            StatsCardWidget(
                              title: AppStrings.lowStockProducts,
                              value: state.stats.lowStockProducts.toString(),
                              icon: Icons.warning,
                              color: AppColors.warning,
                            ),
                            StatsCardWidget(
                              title: AppStrings.todaySales,
                              value: state.stats.todaySales.toString(),
                              icon: Icons.shopping_cart,
                              color: AppColors.success,
                            ),
                            StatsCardWidget(
                              title: AppStrings.todayRevenue,
                              value: Formatters.formatCurrency(state.stats.todayRevenue),
                              icon: Icons.attach_money,
                              color: AppColors.secondaryLight,
                            ),
                            StatsCardWidget(
                              title: AppStrings.monthlyRevenue,
                              value: Formatters.formatCurrency(state.stats.monthlyRevenue),
                              icon: Icons.trending_up,
                              color: AppColors.info,
                            ),
                            StatsCardWidget(
                              title: AppStrings.pendingInvoices,
                              value: state.stats.pendingInvoices.toString(),
                              icon: Icons.pending_actions,
                              color: AppColors.accentLight,
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: AppDimensions.spaceXL),

                    // قسم المبيعات الأخيرة (سيتم إضافته لاحقاً)
                    Text(
                      AppStrings.recentSales,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDimensions.spaceMD),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimensions.paddingLG),
                        child: Center(
                          child: Text(
                            'سيتم إضافة المبيعات الأخيرة بعد بناء Invoices Feature',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/// قائمة جانبية (Drawer)
class _DashboardDrawer extends StatelessWidget {
  const _DashboardDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.book, size: AppDimensions.iconXL, color: Colors.white),
                const SizedBox(height: AppDimensions.spaceSM),
                Text(
                  AppStrings.appName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text(AppStrings.dashboard),
            selected: true,
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text(AppStrings.users),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UsersListPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text(AppStrings.categories),
            onTap: () {
              // TODO: Navigate to categories
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text(AppStrings.products),
            onTap: () {
              // TODO: Navigate to products
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping),
            title: const Text(AppStrings.suppliers),
            onTap: () {
              // TODO: Navigate to suppliers
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.warehouse),
            title: const Text(AppStrings.stock),
            onTap: () {
              // TODO: Navigate to stock
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text(AppStrings.invoices),
            onTap: () {
              // TODO: Navigate to invoices
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text(AppStrings.reports),
            onTap: () {
              // TODO: Navigate to reports
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(AppStrings.settings),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(AppStrings.logout),
            onTap: () {
              Navigator.of(context).pop();
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('تسجيل الخروج'),
                  content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to login
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
                      },
                      child: const Text('تسجيل الخروج'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
