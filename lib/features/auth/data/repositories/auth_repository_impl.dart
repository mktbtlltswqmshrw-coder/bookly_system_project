import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/core/network/network_info.dart';
import 'package:bookly_system/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

/// تطبيق Repository للمصادقة
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserEntity>> login({required String email, required String password}) async {
    // التحقق من الاتصال بالإنترنت
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final user = await remoteDataSource.login(email: email, password: password);
      return Right(user.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ غير متوقع: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ في تسجيل الخروج: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ في الحصول على المستخدم: $e'));
    }
  }

  @override
  bool get isAuthenticated => remoteDataSource.isAuthenticated;

  @override
  Stream<bool> get authStateChanges => remoteDataSource.authStateChanges;
}
