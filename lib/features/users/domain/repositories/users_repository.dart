import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

/// واجهة Repository لإدارة المستخدمين
abstract class UsersRepository {
  /// جلب قائمة المستخدمين
  Future<Either<Failure, List<UserEntity>>> getUsers({String? role, bool? isActive});

  /// جلب مستخدم بالـ ID
  Future<Either<Failure, UserEntity>> getUserById(String id);

  /// إضافة مستخدم جديد
  Future<Either<Failure, UserEntity>> addUser({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    required UserRole role,
    List<String>? permissions,
  });

  /// تحديث بيانات المستخدم
  Future<Either<Failure, UserEntity>> updateUser({required String id, String? fullName, String? phone, UserRole? role});

  /// حذف المستخدم (soft delete)
  Future<Either<Failure, Unit>> deleteUser(String id);

  /// تفعيل المستخدم
  Future<Either<Failure, Unit>> activateUser(String id);

  /// إيقاف المستخدم
  Future<Either<Failure, Unit>> deactivateUser(String id);

  /// تحديث صلاحيات المستخدم
  Future<Either<Failure, Unit>> updatePermissions(String id, List<String> permissions);
}
