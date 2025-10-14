part of 'dashboard_bloc.dart';

/// حالات لوحة التحكم
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

/// الحالة الأولية
class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

/// جاري التحميل
class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

/// تم تحميل الإحصائيات
class DashboardStatsLoaded extends DashboardState {
  final DashboardStatsEntity stats;

  const DashboardStatsLoaded(this.stats);

  @override
  List<Object> get props => [stats];
}

/// حدث خطأ
class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object> get props => [message];
}
