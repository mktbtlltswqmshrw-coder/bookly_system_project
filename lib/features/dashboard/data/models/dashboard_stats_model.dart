import 'package:bookly_system/features/dashboard/domain/entities/dashboard_stats_entity.dart';

/// نموذج إحصائيات لوحة التحكم
class DashboardStatsModel extends DashboardStatsEntity {
  const DashboardStatsModel({
    required super.totalProducts,
    required super.lowStockProducts,
    required super.todaySales,
    required super.todayRevenue,
    required super.monthlyRevenue,
    required super.pendingInvoices,
  });

  /// من JSON
  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalProducts: json['total_products'] as int? ?? 0,
      lowStockProducts: json['low_stock_products'] as int? ?? 0,
      todaySales: json['today_sales'] as int? ?? 0,
      todayRevenue: (json['today_revenue'] as num?)?.toDouble() ?? 0.0,
      monthlyRevenue: (json['monthly_revenue'] as num?)?.toDouble() ?? 0.0,
      pendingInvoices: json['pending_invoices'] as int? ?? 0,
    );
  }

  /// إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'total_products': totalProducts,
      'low_stock_products': lowStockProducts,
      'today_sales': todaySales,
      'today_revenue': todayRevenue,
      'monthly_revenue': monthlyRevenue,
      'pending_invoices': pendingInvoices,
    };
  }

  /// تحويل إلى Entity
  DashboardStatsEntity toEntity() {
    return DashboardStatsEntity(
      totalProducts: totalProducts,
      lowStockProducts: lowStockProducts,
      todaySales: todaySales,
      todayRevenue: todayRevenue,
      monthlyRevenue: monthlyRevenue,
      pendingInvoices: pendingInvoices,
    );
  }
}
