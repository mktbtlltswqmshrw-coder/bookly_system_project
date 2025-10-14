import 'package:bookly_system/core/error/failures.dart';
import 'package:bookly_system/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

/// واجهة Repository للمصادقة
abstract class AuthRepository {
  /// تسجيل الدخول
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  /// تسجيل الخروج
  Future<Either<Failure, Unit>> logout();

  /// الحصول على المستخدم الحالي
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// التحقق من تسجيل الدخول
  bool get isAuthenticated;

  /// مراقبة حالة تسجيل الدخول
  Stream<bool> get authStateChanges;
}
