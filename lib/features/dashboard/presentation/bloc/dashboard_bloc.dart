import 'package:bookly_system/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:bookly_system/features/dashboard/domain/usecases/get_dashboard_stats_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

/// Bloc للوحة التحكم
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardStatsUseCase getDashboardStatsUseCase;

  DashboardBloc({required this.getDashboardStatsUseCase}) : super(const DashboardInitial()) {
    on<LoadDashboardStatsEvent>(_onLoadDashboardStats);
    on<RefreshDashboardStatsEvent>(_onRefreshDashboardStats);
  }

  /// معالج تحميل الإحصائيات
  Future<void> _onLoadDashboardStats(LoadDashboardStatsEvent event, Emitter<DashboardState> emit) async {
    emit(const DashboardLoading());

    final result = await getDashboardStatsUseCase();

    result.fold((failure) => emit(DashboardError(failure.message)), (stats) => emit(DashboardStatsLoaded(stats)));
  }

  /// معالج تحديث الإحصائيات
  Future<void> _onRefreshDashboardStats(RefreshDashboardStatsEvent event, Emitter<DashboardState> emit) async {
    // لا نعرض Loading عند التحديث، فقط نحدث البيانات
    final result = await getDashboardStatsUseCase();

    result.fold((failure) => emit(DashboardError(failure.message)), (stats) => emit(DashboardStatsLoaded(stats)));
  }
}
