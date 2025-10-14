import 'package:dartz/dartz.dart';
import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/dashboard/domain/entities/dashboard_stats_entity.dart';

/// واجهة Repository للوحة التحكم
abstract class DashboardRepository {
  /// الحصول على إحصائيات لوحة التحكم
  Future<Either<Failure, DashboardStatsEntity>> getDashboardStats();
}
