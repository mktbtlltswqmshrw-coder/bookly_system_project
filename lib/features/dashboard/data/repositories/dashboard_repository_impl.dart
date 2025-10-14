import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/core/network/network_info.dart';
import 'package:bookly_system/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:bookly_system/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:bookly_system/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

/// تطبيق Repository للوحة التحكم
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DashboardRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, DashboardStatsEntity>> getDashboardStats() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final stats = await remoteDataSource.getDashboardStats();
      return Right(stats.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ غير متوقع: $e'));
    }
  }
}
