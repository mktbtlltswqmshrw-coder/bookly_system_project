import 'package:dartz/dartz.dart';
import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:bookly_system/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Use Case للحصول على إحصائيات لوحة التحكم
class GetDashboardStatsUseCase {
  final DashboardRepository repository;

  GetDashboardStatsUseCase(this.repository);

  Future<Either<Failure, DashboardStatsEntity>> call() async {
    return await repository.getDashboardStats();
  }
}
