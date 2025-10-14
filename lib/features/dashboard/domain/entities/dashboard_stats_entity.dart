import 'package:equatable/equatable.dart';

/// كيان إحصائيات لوحة التحكم
class DashboardStatsEntity extends Equatable {
  final int totalProducts;
  final int lowStockProducts;
  final int todaySales;
  final double todayRevenue;
  final double monthlyRevenue;
  final int pendingInvoices;

  const DashboardStatsEntity({
    required this.totalProducts,
    required this.lowStockProducts,
    required this.todaySales,
    required this.todayRevenue,
    required this.monthlyRevenue,
    required this.pendingInvoices,
  });

  @override
  List<Object> get props => [
    totalProducts,
    lowStockProducts,
    todaySales,
    todayRevenue,
    monthlyRevenue,
    pendingInvoices,
  ];
}
