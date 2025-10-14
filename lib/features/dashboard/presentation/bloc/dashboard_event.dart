part of 'dashboard_bloc.dart';

/// أحداث لوحة التحكم
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

/// حدث تحميل إحصائيات لوحة التحكم
class LoadDashboardStatsEvent extends DashboardEvent {
  const LoadDashboardStatsEvent();
}

/// حدث تحديث إحصائيات لوحة التحكم
class RefreshDashboardStatsEvent extends DashboardEvent {
  const RefreshDashboardStatsEvent();
}
