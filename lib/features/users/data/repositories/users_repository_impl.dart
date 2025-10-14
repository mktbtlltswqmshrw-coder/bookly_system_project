import 'package:bookly_system/core/error/exceptions.dart';
import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/core/network/network_info.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:bookly_system/features/users/data/datasources/users_remote_datasource.dart';
import 'package:bookly_system/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

/// تطبيق Repository لإدارة المستخدمين
class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UsersRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers({String? role, bool? isActive}) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final users = await remoteDataSource.getUsers(role: role, isActive: isActive);
      return Right(users.map((user) => user.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ غير متوقع: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final user = await remoteDataSource.getUserById(id);
      return Right(user.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ غير متوقع: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> addUser({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    required UserRole role,
    List<String>? permissions,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final user = await remoteDataSource.addUser(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        role: role,
        permissions: permissions,
      );
      return Right(user.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ في إضافة المستخدم: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser({
    required String id,
    String? fullName,
    String? phone,
    UserRole? role,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final user = await remoteDataSource.updateUser(id: id, fullName: fullName, phone: phone, role: role);
      return Right(user.toEntity());
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ في تحديث المستخدم: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.deleteUser(id);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ في حذف المستخدم: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> activateUser(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.updateUserStatus(id, true);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ في تفعيل المستخدم: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deactivateUser(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.updateUserStatus(id, false);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ في إيقاف المستخدم: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePermissions(String id, List<String> permissions) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.updatePermissions(id, permissions);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('حدث خطأ في تحديث الصلاحيات: $e'));
    }
  }
}
